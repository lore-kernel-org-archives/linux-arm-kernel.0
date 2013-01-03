From: bevenson@melinkcorp.com (Bryan Evenson)
Date: Thu, 3 Jan 2013 13:40:43 -0500
Subject: Early kernel hang with big DTB appended
In-Reply-To: <7811936.npteFbuYu2@amdc1227>
References: <7811936.npteFbuYu2@amdc1227>
Message-ID: <91586D499ADFD74FBCFB8425266A5DE40139F1B06030@pluto.melinkcorp.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Tomasz Figa
> Sent: Thursday, January 03, 2013 10:55 AM
> To: devicetree-discuss at lists.ozlabs.org
> Cc: linux-samsung-soc at vger.kernel.org; linux at arm.linux.org.uk;
> nico at linaro.org; kgene.kim at samsung.com; thomas.abraham at linaro.org;
> bones at secretlab.ca; linux-arm-kernel at lists.infradead.org
> Subject: Early kernel hang with big DTB appended
> 
> Hi,
> 
> I'm observing strange behavior when booting 3.8-rc1 and -rc2 with
> appended DTB. The kernel hangs very early when the DTB is bigger than
> some threshold somewhere around 24 KiB. With fullest possible low level
> UART debugging (and printk patched to use printascii) I'm receiving
> following
> output:
> 
> Uncompressing Linux... done, booting the kernel.
> Booting Linux on physical CPU 0xa00
> Linux version 3.8.0-rc1-00073-gdf6efca-dirty (t.figa at amdc1227) (gcc
> version 4.5.2 (Gentoo 4.5.2 p1.2, pie-0.4.5) ) #2 SMP PREEMPT Thu Jan 3
> 15:37:35 CET 2013
> CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c53c7d
> CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction
> cache
> 
> I tested on two Exynos-based boards (exynos4210-trats and one internal
> exynos4412-based board) and same happens on both.
> 
> Do you have any ideas?

Tomasz,

Sounds to me like the DTB is not being fully written to memory or that it isn't being fully read from memory.  I've had similar problems when I placed the DTB too close to the end of flash and not all of the DTB was written to flash.

If you load a debug build of U-Boot, I believe there are a number of debug messages related to loading the device tree that U-Boot prints.  Then you can at least verify that U-Boot is loading the entire device tree.

Regards,
Bryan

> 
> Best regards,
> --
> Tomasz Figa
> Samsung Poland R&D Center
> SW Solution Development, Linux Platform
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
