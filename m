From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Feb 2012 06:38:04 +0000
Subject: [PATCH v3] ARM: LPC32xx: Ethernet support
In-Reply-To: <083DF309106F364B939360100EC290F81F365B2B2A@eu1rdcrdc1wx030.exi.nxp.com>
References: <1330364762-23203-1-git-send-email-stigge@antcom.de>
 <4F4BFDD2.8060007@antcom.de>
 <083DF309106F364B939360100EC290F81F365B2B2A@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <201202280638.04634.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 27 February 2012, Kevin Wells wrote:
> >
> >For the driver, some style fixes were applied, and the cmdline
> >"ethaddr" was removed, relying on the bootloader to set it correctly
> > (and it actually does, it actually needs to prepare TFTP booting).
> 
> I'm not sure I'd trust the bootloader to always set the MAC address
> in hardware prior to calling the kernel. A lot of u-boot MAC drivers,
> including the 32x0's, only set the MAC address on the call to
> eth_init(), which is only called when the network interface is used.
> If you do a MTD based kernel boot, the MAC address will probably be
> invalid if you try to do a NFS mount for the filesystem.

In the long run, the MAC address should probably be set by the boot
loader through the device tree that is passed to the kernel, overriding
the one in the registers when set.

When we do that, we won't need the command line argument any more.
Some drivers have it anyway, but IMHO the cleaner approach would
be having fewer methods to pass it.

	Arnd
