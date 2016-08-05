From: kbeldan@baylibre.com (Karl Beldan)
Date: Fri, 5 Aug 2016 14:45:07 +0000
Subject: [PATCH] ARM: dts: da850: Add basic DTS for the L138/C6748 Dev Kit
In-Reply-To: <57A49F3A.9030306@ti.com>
References: <20160804144332.4841-1-kbeldan@baylibre.com>
 <57A49F3A.9030306@ti.com>
Message-ID: <20160805144507.GA24855@gobelin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 05, 2016 at 07:44:18PM +0530, Sekhar Nori wrote:
> On Thursday 04 August 2016 08:13 PM, Karl Beldan wrote:
> > The LCDK is the successor to the late Hawkboard and has the same machine
> > number.
> > Among the differences are the flash (16bits vs 8bits) and some pins
> > (MMC, LEDs, buttons, some external connectors), however the main
> > components remain the same (eth. PHY, Audio Codec, Video decoder and
> > DAC) except for the main PMIC, different and hard-wired on the LCDK (the
> > LDOs and DCDCs are always ON).
> > A DT-only boot with this addition gives functional uart, reboot via
> > watchdog, rtc, ethernet and MMC (I added the CD gpio for the MMC
> > although davinci_mmc doesn't call yet the mmc core OF facilities).
> > 
> > Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> 
> C6748 is a pin-compatible DSP-only part which does not run Linux. The
> OMAP-L138 and C6748 LCDKs are physically different boards. So, I would
> just stick with subject line ".. for the OMAP-L138 LCDK board"
> 
That was my understanding but LCDK stands for L138-C6748-Dev-Kit right ?
Anyways, I'll remove the said references as per your request.

> > ---
> >  Documentation/devicetree/bindings/arm/davinci.txt |  4 ++
> >  arch/arm/boot/dts/Makefile                        |  1 +
> >  arch/arm/boot/dts/omapl138-lcdk.dts               | 71 +++++++++++++++++++++++
> >  arch/arm/mach-davinci/da8xx-dt.c                  |  1 +
> >  4 files changed, 77 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/omapl138-lcdk.dts
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/davinci.txt b/Documentation/devicetree/bindings/arm/davinci.txt
> > index cfaeda4..1482c74 100644
> > --- a/Documentation/devicetree/bindings/arm/davinci.txt
> > +++ b/Documentation/devicetree/bindings/arm/davinci.txt
> > @@ -5,6 +5,10 @@ DA850/OMAP-L138/AM18x Evaluation Module (EVM) board
> >  Required root node properties:
> >      - compatible = "ti,da850-evm", "ti,da850";
> >  
> > +DA850/OMAP-L138/AM18x L138/C6748 Development Kit (LCDK) board
> 
> here too, drop reference to C6748.
> 
Ditto.

> > +Required root node properties:
> > +    - compatible = "ti,omapl138-lcdk", "ti,da850";
> 
> let the compatible be "ti,da850-lcdk" for consistency.
> 
Kevin pointed that out.

> > +
> >  EnBW AM1808 based CMC board
> >  Required root node properties:
> >      - compatible = "enbw,cmc", "ti,da850;
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 414b427..da3f69b 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -105,6 +105,7 @@ dtb-$(CONFIG_ARCH_BERLIN) += \
> >  dtb-$(CONFIG_ARCH_BRCMSTB) += \
> >  	bcm7445-bcm97445svmb.dtb
> >  dtb-$(CONFIG_ARCH_DAVINCI) += \
> > +	omapl138-lcdk.dtb \
> >  	da850-enbw-cmc.dtb \
> >  	da850-evm.dtb
> >  dtb-$(CONFIG_ARCH_DIGICOLOR) += \
> > diff --git a/arch/arm/boot/dts/omapl138-lcdk.dts b/arch/arm/boot/dts/omapl138-lcdk.dts
> > new file mode 100644
> > index 0000000..fad3b6d
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/omapl138-lcdk.dts
> > @@ -0,0 +1,71 @@
> > +/*
> > + * Copyright (c) 2016 BayLibre, Inc.
> > + *
> > + * Licensed under GPLv2 or later.
> 
> are you sure about "or later"?
> 
I will remove it.
 
Karl
