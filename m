From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 15 Nov 2012 06:42:46 +1300
Subject: arch-vt8500 and wm8850 support
In-Reply-To: <201211141117.33485.arnd@arndb.de>
References: <1352879641.2728.8.camel@gitbox> <201211141117.33485.arnd@arndb.de>
Message-ID: <1352914966.3238.3.camel@gitbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Yes, makes sense. Actually with the move to multiplatform, you already
> need to make the decision for the CPU earlier on, since the multiplatform
> kernel can only be built either for ARMv4/v5 or for ARMv6/v7.
> 
> I would suggest doing it like
> 
> config ARCH_VT8500
> 	bool
> 	select FOO
> 	select BAR
> 
> config ARCH_WM8505
> 	bool "WonderMedia WM8505 or VIA VT8500"
> 	depends on ARCH_MULTI_V5
> 	select ARCH_VT8500
> 	select CPU_ARM926
> 
> config ARCH_WM8650
> 	bool "WonderMedia WM 8650"
> 	depends on ARCH_MULTI_V6
> 	select ARCH_VT8500
> 	select CPU_V6
> 
> config ARCH_WM8850
> 	bool "WonderMedia WM 8750/8850"
> 	depends on ARCH_MULTI_V7
> 	select ARCH_VT8500
> 	select CPU_V7
> 
> This keeps ARCH_VT8500 as the overall name for the family, but
> lists only the WonderMedia parts in the configuration.
> 
> 	Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Makes sense - That's basically what I had in mind. My concern is with
the bit that made no sense to me - the non-multiplatform version of the
same. At the moment, we have the default xx_SINGLE for ARCH_VT8500.
Would I need to add an additional xx_SINGLE variant for each different
version?

We would need ARCH_WM8505 (To cover VT8500/WM8505/WM8650 ARM926),
ARCH_WM8750 (for ARMv6) and ARCH_WM8850 (for ARMv7).

Do I need a ARCH_WM8750_SINGLE, ARCH_WM8850_SINGLE etc for each one to
allow use to continue using earlyprintk?

Regards
Tony P
