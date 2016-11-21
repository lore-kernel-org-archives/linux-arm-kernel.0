From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 21 Nov 2016 09:22:10 +0100
Subject: [GIT PULL 9/10] arm64: tegra: Device tree changes for v4.10-rc1
In-Reply-To: <20161119024021.GT2543@localhost>
References: <20161118161719.24153-1-thierry.reding@gmail.com>
 <20161118161719.24153-9-thierry.reding@gmail.com>
 <20161119024021.GT2543@localhost>
Message-ID: <20161121082210.GD25171@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 06:40:21PM -0800, Olof Johansson wrote:
> On Fri, Nov 18, 2016 at 05:17:18PM +0100, Thierry Reding wrote:
> > Hi ARM SoC maintainers,
> > 
> > The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> > 
> >   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> > 
> > are available in the git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.10-arm64-dt
> > 
> > for you to fetch changes up to cc13b4fa4ac780cec6c21b64a39ab2950e95e8f6:
> > 
> >   arm64: tegra: Add NVIDIA P2771 board support (2016-11-18 14:35:53 +0100)
> > 
> > Thanks,
> > Thierry
> > 
> > ----------------------------------------------------------------
> > arm64: tegra: Device tree changes for v4.10-rc1
> > 
> > This adds initial support for Tegra186, the P3310 processor module as
> > well as the P2771 development board. Not much is functional, but there
> > is enough to boot to an initial ramdisk with debug serial output.
> > 
> > ----------------------------------------------------------------
> > Dan Carpenter (1):
> >       mailbox: tegra-hsp: Use after free in tegra_hsp_remove_doorbells()
> > 
> > Joseph Lo (6):
> >       soc/tegra: Add Tegra186 support
> >       dt-bindings: mailbox: Add Tegra HSP binding
> >       dt-bindings: firmware: Add bindings for Tegra BPMP
> >       arm64: tegra: Add Tegra186 support
> >       arm64: tegra: Add NVIDIA P3310 processor module support
> >       arm64: tegra: Add NVIDIA P2771 board support
> > 
> > Stephen Warren (2):
> >       dt-bindings: Add power domains to Tegra BPMP firmware
> >       dt-bindings: firmware: Allow child nodes inside the Tegra BPMP
> > 
> > Thierry Reding (12):
> >       Merge branch 'for-4.10/soc' into for-4.10/mailbox
> >       mailbox: Add Tegra HSP driver
> >       Merge branch 'for-4.10/mailbox' into for-4.10/firmware
> >       firmware: tegra: Add IVC library
> >       firmware: tegra: Add BPMP support
> >       Merge branch 'for-4.10/firmware' into for-4.10/arm64/dt
> >       arm64: tegra: Add CPU nodes for Tegra186
> >       arm64: tegra: Add serial ports on Tegra186
> >       arm64: tegra: Add I2C controllers on Tegra186
> >       arm64: tegra: Add SDHCI controllers on Tegra186
> >       arm64: tegra: Add GPIO controllers on Tegra186
> >       arm64: tegra: Enable PSCI on P3310
> 
> The drivers->dt dependency here is annoying. Any chance you can respin without
> it?
> 
> We've been encouraging people to consider using numerical clock/gpio/reset
> numbers on initial submission to avoid these dependencies on dt-bindings
> includes, and then follow up with a move to the symbolic names between -rc1 and
> -rc2. Mind doing the same here?

Yes, I can do that. Would it be acceptable to have a dt-bindings->dt
dependency? Stephen's already done a good job of avoiding this kind of
dependency by getting the bindings, and hence dt-bindings headers,
merged ahead of Linux kernel support because he had already gotten the
bindings reviewed and finalized during his work on U-Boot.

I've been told in the past that it's not necessary to strictly split DT
bindings patches from driver patches, but I suppose if a dt-bindings->dt
is acceptable, then splitting things up more strictly would actually be
the preferable solution here because it also avoids the slight churn of
converting to symbolic values later on.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161121/ca5e5c61/attachment-0001.sig>
