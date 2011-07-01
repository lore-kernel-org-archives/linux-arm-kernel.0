From: b32955@freescale.com (Huang Shijie)
Date: Fri, 1 Jul 2011 16:57:40 +0800
Subject: reply: [PATCH v5 1/3] ARM: mxs: add GPMI-NFC support for
	imx23/imx28
In-Reply-To: <201107010029.51965.arnd@arndb.de>
References: <14C4E31473AF7E4B98176CB73615181C19FBD3@039-SN1MPN1-006.039d.mgd.msft.net>
	<201107010029.51965.arnd@arndb.de>
Message-ID: <4E0D8C04.6010409@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi;
> On Thursday 30 June 2011 18:12:27 Huang Shijie-B32955 wrote:
>> I think gpmi-nfc is much better then gpmi-nand or gpmi-flash.
> Then how do you want to name the near field communication drivers?
>
what's meaning of "near field communication" ?

>>> I know that you didn't start this pattern, but I find these macros
>>> extremely annoying. It obscures the use of the macros with the
>>> string concatenation and the macro names are way too generic
>>> for something platform specific. If people think it's a good idea
>>> to have these, please submit a patch to add macros (without the
>>> string concatenation) into include/linux/ioport.h.
>>> Until then, better spell out the resources.
>> ==============================================
>> I ever tried several methods,  but  I can not find a better method to
>> replace the current method.
>>
>> It's annoying, but it really saves some lines.
> It would save more lines if you introduce the macros globally and
> convert all existing resource definitions ;-)
The origin code did not use any macros.
Some one suggested me to use macros.
So i used the macros.

Do i have to drop the macros?



> Making code shorter is usually a good idea, but not when it conflicts
> with readability. Adding custom macros that do string concatenation
> is such a case.
>
>>> When adding new infrastructure, always keep in mind how you want it to look
>>> after the device tree conversion. The partitions and min/max_* are easily covered
>>> with that, but the init/exit function pointers are somewhat problematic.
>>> Fortunately, you don't really require these functions for this driver. The _exit
>>> function is completely unused, so just get rid of it.
>> ===================================================
>> I am reluctant to remove it, I am not sure whether I will use the _exit() in future.
>> But, yes, it can be removed now.
> As a rule, you should never introduce infrastructure just because you might
> need it in the future but don't know if you will really need it.
thanks. I will remove it in next version.

> This is even more important for the actual driver, as I mentioned in my other
> mail. You have a hardware abstraction layer, but only one variant of the hardware
> posted along with the driver. Without seeing different hardware, how should
> anyone be able to tell whether the abstraction is really needed or if it's the
> correct abstraction?
Best Regards
Huang Shijie
> 	Arnd
>
