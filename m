From: olof@lixom.net (Olof Johansson)
Date: Wed, 15 Feb 2012 12:12:19 -0800
Subject: [PATCH] ARM: need to include asm/system.h in asm/processor.h
In-Reply-To: <4F3C1051.7010404@gmail.com>
References: <1329333610-4474-1-git-send-email-olof@lixom.net>
 <20120215195927.GA31373@codeaurora.org>
 <4F3C1051.7010404@gmail.com>
Message-ID: <CAOesGMjTY1hmzdPK-XSf44jY+G-=P0m6wXWetGqVSKWKUtyAJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2012 at 12:06 PM, Rob Herring <robherring2@gmail.com> wrote:
> On 02/15/2012 01:59 PM, David Brown wrote:
>> On Wed, Feb 15, 2012 at 11:20:10AM -0800, Olof Johansson wrote:
>>> For files that include asm/processor.h but not asm/system.h:
>>>
>>> arch/arm/mach-msm/include/mach/uncompress.h: In function 'putc':
>>> arch/arm/mach-msm/include/mach/uncompress.h:48:3: error: implicit declaration of function 'smp_mb' [-Werror=implicit-function-declaration]
>>>
>>> In this case, smp_mb() is from the cpu_relax() call in the msm putc().
>>>
>>> It likely went uncaught when the uncompress.h change went in since the
>>> defconfig didn't enable that code path, but later changes (e76f4750f4:
>>> ARM: debug: arrange Kconfig options more logically) resulted in the
>>> option being on for msm_defconfig and thus exposed it.
>>>
>>> Signed-off-by: Olof Johansson <olof@lixom.net>
>>
>> BTW, Rob Herring has this same patch in his io.h cleanup patches, so
>> it's probably best to coordinate with him.
>
> I'd just assumed that I had broken things by implicitly dropping a lot
> of includes when removing mach/io.h. Go ahead and apply yours and I'll
> drop mine.

Cool, I had missed that -- sorry for the duplicate patches.

I'll forward mine now to Russell's patch tracker and he can pick it up there.


-Olof
