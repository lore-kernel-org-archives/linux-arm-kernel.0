From: treding@nvidia.com (Thierry Reding)
Date: Thu, 21 Jan 2016 17:20:37 +0100
Subject: [PATCH v3 3/5] soc: rockchip: add reboot notifier driver
In-Reply-To: <2250962.OgUpqMgY4k@wuerfel>
References: <1447840044-19689-1-git-send-email-andy.yan@rock-chips.com>
 <15127971.1juVbocOjP@wuerfel>
 <20151228092054.GA29195@ulmo.nvidia.com>
 <2250962.OgUpqMgY4k@wuerfel>
Message-ID: <20160121162035.GG647@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 28, 2015 at 04:35:46PM +0100, Arnd Bergmann wrote:
> On Monday 28 December 2015 10:20:56 Thierry Reding wrote:
> > > > > HTC apparently uses a separate RAM area to pass the reboot reason,
> > > > > and they have a driver to store that, which is separate from the
> > > > > driver that they use for actually rebooting the machine.
> > > > 
> > > > I wasn't very clear, but the PMC_SCRATCH0 register is used to store the
> > > > reset reason. It supports the recovery mode, which I think is really an
> > > > Android thing, "bootloader" will typically cause the bootloader not to
> > > > boot anything, and "forced-recovery" will go into a recovery mode that
> > > > is used to bootstrap the device (usually by uploading a "miniloader"
> > > > that initializes RAM, downloads a bootloader for booting or flashing an
> > > > operating system, ...).
> > > > 
> > > > The write that resets the SoC is to a different register.
> > > 
> > > So is this scratch register interpreted by some maskrom code, or by code that
> > > can be provided by the OEM?
> > 
> > My understanding is that its interpreted both by what's called BootROM
> > on Tegra (I guess that's what you call "maskrom code") and the system's
> > bootloader. The BootROM cannot typically be replaced by the OEM, but it
> > is quite typical for the bootloader to differ between devices.
> 
> Ok, so not maskrom (which would not be OEM specific, but hardcoded for
> the chip) but rather some form of PROM. This means we can only guess
> that all OEMs use the same protocol but in theory someone could have
> implemented an incompatible BootROM, but it's also possible that HTC
> just ignore the register entirely and implement the same thing separately.

I wasn't being clear, the BootROM is hardcoded for the chip, I'm not
aware of a way to replace it once the chip's taped out.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160121/8a6f284b/attachment.sig>
