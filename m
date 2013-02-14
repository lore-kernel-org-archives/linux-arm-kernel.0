From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 14 Feb 2013 09:06:52 -0300
Subject: Build error: OMAP randconfig / mvebu
In-Reply-To: <201302141127.07378.arnd@arndb.de>
References: <20130208100813.GN17833@n2100.arm.linux.org.uk>
 <20130214110803.GP17852@n2100.arm.linux.org.uk>
 <20130214111234.GB3059@localhost>
 <201302141127.07378.arnd@arndb.de>
Message-ID: <20130214120650.GA11345@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Feb 14, 2013 at 11:27:07AM +0000, Arnd Bergmann wrote:
> On Thursday 14 February 2013, Ezequiel Garcia  wrote:
> > On Thu, Feb 14, 2013 at 11:08:03AM +0000, Russell King - ARM Linux wrote:
> > > 
> > > It's all publically available via my website.
> > 
> > I'm kind of new around here, and I have no clue where that may be.
> > 
> > I hope you don't mind helping me this time.
> 
> 
> Please have a look at http://www.arm.linux.org.uk/developer/build/

Okey.

FYI, using the random config file for OMAP4430 and also with a manual
config that chooses ARCH_MVEBU but doesn't choose MACH_ARMADA_XP or
MACH_ARMADA_370, this make error is *gone* after applying your patch:

arch/arm/mach-mvebu/built-in.o: In function `armada_xp_smp_init_cpus':
:(.init.text+0x74): undefined reference to `coherency_get_cpu_count'
:(.init.text+0xb8): undefined reference to `armada_mpic_send_doorbell'
arch/arm/mach-mvebu/built-in.o: In function `armada_xp_smp_prepare_cpus':
:(.init.text+0x250): undefined reference to `set_cpu_coherent'
arch/arm/mach-mvebu/built-in.o: In function `armada_xp_boot_secondary':
:(.cpuinit.text+0x10): undefined reference to `armada_xp_boot_cpu'
arch/arm/mach-mvebu/built-in.o: In function `armada_xp_secondary_init':
:(.cpuinit.text+0x2c): undefined reference to `armada_xp_mpic_smp_cpu_init'
arch/arm/mach-mvebu/built-in.o: In function `armada_xp_secondary_startup':
:(.cpuinit.text+0x40): undefined reference to `ll_set_cpu_coherent'

Now, using the random config there's a new error, unrelated to the
previous one:

ERROR: "twl6030_interrupt_unmask" [drivers/usb/otg/twl6030-usb.ko] undefined!
ERROR: "twl_i2c_read_u8" [drivers/usb/otg/twl6030-usb.ko] undefined!
ERROR: "twl_i2c_write_u8" [drivers/usb/otg/twl6030-usb.ko] undefined!
ERROR: "twl6030_interrupt_mask" [drivers/usb/otg/twl6030-usb.ko] undefined!

Regards,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
