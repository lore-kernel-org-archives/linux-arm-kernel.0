From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 12 Jul 2017 18:54:42 +0200
Subject: [PATCH 0/6] Macchiatobin updates
In-Reply-To: <20170708191317.GM4902@n2100.armlinux.org.uk> (Russell King's
 message of "Sat, 8 Jul 2017 20:13:17 +0100")
References: <20170708191317.GM4902@n2100.armlinux.org.uk>
Message-ID: <87fue1bnot.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell King,
 
 On sam., juil. 08 2017, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> This series, based upon the 4.12-rc6 backports branch in the MISL tree:
> - adds a maintainer entry for the Macchiatobin board.
> - adds GPIO interrupt support to the CP110s
> - adds the pinmux entries
> - corrects the 5V regulator GPIO entry
> - adds support for the I2C mux (used for the SFP slots)
> - adds PCIe support
>
> All entries include the appropriate pinmux and GPIO configuration.
>
> PCIe support has not been tested locally as I have no PCIe cards to
> test with; this patch includes support for the PCIe reset GPIO signal.
> If others can test that patch and let me know whether it works, I would
> be most grateful.
>

The first patch had been applied on mvebu/arm64-for-4.14.

Patch 2 to 6 had been applied on mvebu/dt64-for-4.14.

For the patch 4, I merged it with the patch that Thomas previously sent
because it was not in mainline yet even if it was on the backport
branch. The resulting patch is attached.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-arm64-dts-marvell-fix-USB3-regulator-definition-on-M.patch
Type: text/x-diff
Size: 2133 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170712/7c7ddc27/attachment.bin>
-------------- next part --------------


Finally I tested the last patch with an Ethernet PCIe card it worked
well, but the reset part was not tested as I don't know how it should be
tested.

As soon as the v4.13-rc1 will be released then the branches will be rebased
on it and renamed mvebu/arm64 and mvebu/dt64.

Thanks,

Gregory


>  MAINTAINERS                                        |  6 ++
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  | 89 +++++++++++++++++++++-
>  .../boot/dts/marvell/armada-cp110-master.dtsi      | 11 ++-
>  .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 11 ++-
>  4 files changed, 112 insertions(+), 5 deletions(-)
>
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
