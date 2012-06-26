From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 26 Jun 2012 10:04:32 +0100
Subject: [PATCH 08/14] mfd: Add IRQ domain support for the AB8500
In-Reply-To: <CACRpkdYszGAixL_2CiPLRJ2Pasq_GwxnR1np+y83miOXhanNQg@mail.gmail.com>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-9-git-send-email-lee.jones@linaro.org>
 <20120614183231.GA30185@sirena.org.uk> <4FDEEEBD.5070108@linaro.org>
 <20120618102003.GB12029@n2100.arm.linux.org.uk>
 <20120618185638.GY3974@opensource.wolfsonmicro.com>
 <4FE1C952.5000306@linaro.org>
 <CACRpkdYszGAixL_2CiPLRJ2Pasq_GwxnR1np+y83miOXhanNQg@mail.gmail.com>
Message-ID: <4FE97B20.6000809@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/06/12 08:37, Linus Walleij wrote:
> On Wed, Jun 20, 2012 at 3:00 PM, Lee Jones<lee.jones@linaro.org>  wrote:
>> On 18/06/12 19:56, Mark Brown wrote:
>>>
>>> Yes, that's correct.  I'm surprised the code runs without crashing...
>>
>> Oddly the code ran perfectly.
>
> So how did you test it?
>
> The only way to generate an IRQ on the AB8500 with the mainline code is
> to push the power button, that should generate an event from the
> driver in drivers/input/misc/ab8500-ponkey.c that you can listen to
> by doing cat on the proper /dev/input/eventN file.
>
> Please test this scenario before and after the patch and you have some
> indication that the IRQdomain is working.

Yep, works perfectly fall and rise:

>            CPU0       CPU1
>   6:          0          2    ab8500  ab8500-ponkey-dbf
>   7:          0          2    ab8500  ab8500-ponkey-dbr

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
