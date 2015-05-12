From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 12 May 2015 17:58:24 +0200
Subject: [PATCH 2/8] dmaengine: mv_xor: add support for a38x command in
 descriptor mode
In-Reply-To: <20150512174936.284783d4@free-electrons.com>
References: <1431445063-20226-1-git-send-email-maxime.ripard@free-electrons.com>
 <1431445063-20226-3-git-send-email-maxime.ripard@free-electrons.com>
 <20150512174936.284783d4@free-electrons.com>
Message-ID: <20150512155824.GJ19927@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 05:49:36PM +0200, Thomas Petazzoni wrote:
> Maxime,
> 
> On Tue, 12 May 2015 17:37:37 +0200, Maxime Ripard wrote:
> 
> >  Required properties:
> > -- compatible: Should be "marvell,orion-xor"
> > +- compatible: Should be "marvell,orion-xor" or "marvell,a38x-xor"
> 
> I believe the new compatible string should be armada-380-xor or
> armada380-xor. Wildcards in compatible strings are generally not
> recommended, and we don't use the a38x- prefix anywhere in the tree, as
> far as I can see:
> 
> drivers/ata/ahci_mvebu.c:	{ .compatible = "marvell,armada-380-ahci", },
> drivers/bus/mvebu-mbus.c:	{ .compatible = "marvell,armada380-mbus",
> drivers/mmc/host/sdhci-pxav3.c:		.compatible = "marvell,armada-380-sdhci",
> drivers/rtc/rtc-armada38x.c:	{ .compatible = "marvell,armada-380-rtc", },
> drivers/thermal/armada_thermal.c:		.compatible = "marvell,armada380-thermal",
> drivers/usb/host/xhci-plat.c:	{ .compatible = "marvell,armada-380-xhci"},
> drivers/watchdog/orion_wdt.c:		.compatible = "marvell,armada-380-wdt",
> 
> Yes, we're not very consistent between armada380 and armada-380, but
> we're not using a38x anywhere.

A quick grep for marvell,orion, marvell,kirkwood and marvell,dove
suggests it should have the - if we want to be consistent with older
Marvell devices. As you said, starting with marvell,armanda it gets
pretty inconsistent :-(

	Andrew
