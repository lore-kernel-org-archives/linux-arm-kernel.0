From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 21 Sep 2011 22:04:59 +0800
Subject: [PATCH 15/19] plat-pxa: break out GPIO driver specifics
In-Reply-To: <CACRpkdbGfhZnLaP9p27T1qbD0NVsW7Spp9ZVbR6zEGBSFU+M9g@mail.gmail.com>
References: <1312978697-18572-1-git-send-email-linus.walleij@stericsson.com>
	<CAMPhdO9eL_Sdq-=TCami=CkwWeYR3XeF0K=n9L0uzjS88YTsRA@mail.gmail.com>
	<CACRpkdbGfhZnLaP9p27T1qbD0NVsW7Spp9ZVbR6zEGBSFU+M9g@mail.gmail.com>
Message-ID: <CAMPhdO-3AY-S6dsW4FU2qB5G_7ffqcpj7x3hD-T=uhBvSAzKBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2011 at 4:45 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Aug 10, 2011 at 4:38 PM, Eric Miao <eric.y.miao@gmail.com> wrote:
>> On Wed, Aug 10, 2011 at 8:18 PM, Linus Walleij
>> <linus.walleij@stericsson.com> wrote:
>>> From: Linus Walleij <linus.walleij@linaro.org>
>>>
>>> The <mach/gpio.h> file is included from upper directories
>>> and deal with generic GPIO and gpiolib stuff. Break out the
>>> platform and driver specific defines and functions into its own
>>> header file.
>>>
>>> Cc: Eric Miao <eric.y.miao@gmail.com>
>>> Cc: Russell King <linux@arm.linux.org.uk>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> I think there is better way around this, am working on it with several
>> patches already, will release soon.
>
> Anything happening on this front or shall I update this patch set?

Hi Linus,

Several cleanup patches in my local tree but I didn't manage to find
time to finish the series. Please go ahead update the patch set. We
can fix the problems later.

Haojian,

Could you help on generalize the GPIO support code for PXA? Generally,
the goals are:

1. independent of <mach/gpio.h>, i.e. no #include <mach/gpio.h> so
to support multiple sub-arch in a single kernel, that's to say - possible
to build a single kernel supporting both mach-pxa/ and mach-mmp/

2. as a result of 1), independent of <plat/gpio.h>

Thanks
- eric

>
> Yours,
> Linus Walleij
>
