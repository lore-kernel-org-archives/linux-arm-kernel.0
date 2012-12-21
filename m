From: tony@atomide.com (Tony Lindgren)
Date: Fri, 21 Dec 2012 09:07:11 -0800
Subject: Looking for a V3.X kernel am3517_evm_defconfig file (3.5.7
 preferred)
In-Reply-To: <50D4773E.80802@bbn.com>
References: <50D4773E.80802@bbn.com>
Message-ID: <20121221170710.GN21056@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Martin Grossman <grossman@bbn.com> [121221 07:04]:
> Does anyone know where I can find this file?
> 
> I have tried bringing a 2.6.32 version into a 3.5.7 without any changes
> from kernel.org
> and the uncompress (piggy) code works but then it hangs.
> 
> Are there any patches I need?
> 
> PS I've already fixed the command line /dev/ttyS2 to /dev/tty02 changes
> but still no output.
>     So I have no idea if its not running (something else wrong in the
> config),
>     or its running OK but just not seeing any console output.
> 
> PPS This is on a AM3505/3517 Zoom eval board with a AM3517 chip and it
> currently boots kernel (uImage)
> Linux version 2.6.32 (schuyler_2 at neo) (gcc version 4.3.3 (Sourcery G++
> Lite 2009q1-203) ) #1 Tue Jan 25 16:18:32 CST 2011
> from either the SD card or via tftp (with rootfs always on SD).

You should get basic things booting with omap2plus_defconfig as long
as you have the machine_id related entry in some mach-omap2/board*.c
file.

Maybe enable DEBUG_LL and EARLY_PRINTK in your .config so you can
verify the machine_id? Note that it requires you to have a suitable
entry in arch/arm/mach-omap2/include/mach/uncompress.h.

You may need to patch in omap_uart_phys/virt/lsr in the related
arch/arm/mach-omap2/include/mach/debug-macro.S if the machine_id
is unknown.

Regards,

Tony
