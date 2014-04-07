From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 7 Apr 2014 17:50:54 +0200
Subject: [PATCH 1/4] ata: ahci_mvebu: new driver for Marvell Armada 380
 AHCI interfaces
In-Reply-To: <20140407151823.GG18785@lunn.ch>
References: <1396882664-19297-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1396882664-19297-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140407151823.GG18785@lunn.ch>
Message-ID: <20140407175054.3f57265b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Mon, 7 Apr 2014 17:18:23 +0200, Andrew Lunn wrote:

> > diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> > index 48b285f..271746d 100644
> > --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> > +++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> > @@ -7,7 +7,8 @@ Required properties:
> >  - compatible        : compatible list, one of "snps,spear-ahci",
> >                        "snps,exynos5440-ahci", "ibm,476gtr-ahci",
> >                        "allwinner,sun4i-a10-ahci", "fsl,imx53-ahci"
> > -                      "fsl,imx6q-ahci" or "snps,dwc-ahci"
> > +                      "fsl,imx6q-ahci", "snps,dwc-ahci" or
> > +                      "marvell,armada-380-ahci"
> 
> Hi Thomas
> 
> Since this list is growing, maybe now would be a good time to sort it
> alphabetically?

Ok. I guess this would have to be a separate patch, preliminary to the
introduction of the ahci_mvebu driver.

> > +	dram = mv_mbus_dram_info();
> > +	if (dram)
> > +		ahci_mvebu_mbus_config(hpriv, dram);
> 
> I know this is a common model for mv_sata, which has to deal with
> devices without dram, but can 38x also work without dram? Or should
> missing dram be considered fatal to the probe?

Indeed in the current situation, dram should never be NULL, so the code
could even be:

	ahci_mvebu_mbus_config(hpriv, mv_mbus_dram_info());

Will fix for v2.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
