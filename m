From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Feb 2017 14:51:08 +0100
Subject: [PATCH 0/4] ARM64: Initial Realtek RTD1295 enablement
In-Reply-To: <20170214033440.18667-1-afaerber@suse.de>
References: <20170214033440.18667-1-afaerber@suse.de>
Message-ID: <2627010.mZmgFkHdOI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, February 14, 2017 4:34:35 AM CET Andreas F?rber wrote:
> 
> This mini-series adds initial support for the Realtek RTD1295 SoC and
> the Zidoo X9S TV box.
> 
> With these patches CPU0 can be booted with earlycon.
> 
> PSCI doesn't work despite present in the vendor device tree; as enable-method
> it instead used a custom "rtk-spin-table" that I sadly have no source code of.
> 
> The UARTs use a custom interrupt controller that I again lack source code of;
> with interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH> it can boot into an initrd.
> 
> The boot process is slightly twisted: The files need to be loaded from a
> 32-bit U-Boot, then boot into 64-bit U-Boot where the kernel can be booted.
> Similar to my previous Amlogic S905 work, the TEXT_OFFSET poses a problem, so
> a uImage needs to be used (or the kernel patched) for load address 0x00280000.
> I haven't succeeded loading an initrd via bootm/booti; but as quick workaround
> initrd=$rootfs_loadaddr,0x$filesize can manually be specified in $bootargs.
> 
> 

Nice!

You can add my

Acked-by: Arnd Bergmann <arnd@arndb.de>

please them to arm at kernel.org after the merge window as a patch
set, so we can add them for 4.12.

	Arnd
