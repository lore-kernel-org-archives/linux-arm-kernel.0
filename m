From: nikita@compulab.co.il (Nikita Kiryanov)
Date: Mon, 30 Nov 2015 17:32:46 +0200
Subject: [PATCH 12/14] ARM: sb-som: dts: introduce SB-SOM baseboard
In-Reply-To: <20151125225734.GA17604@rob-hp-laptop>
References: <1448371155-17307-1-git-send-email-nikita@compulab.co.il>
 <1448371155-17307-13-git-send-email-nikita@compulab.co.il>
 <20151125225734.GA17604@rob-hp-laptop>
Message-ID: <20151130153246.GA17574@skynet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 04:57:34PM -0600, Rob Herring wrote:
> On Tue, Nov 24, 2015 at 03:19:13PM +0200, Nikita Kiryanov wrote:
> > CompuLab SB-SOM baseboard is a carrier board for multiple arm-based SoMs.
> > It currently supports (with minor adjustments to assembly) CM-T43, CM-T54,
> > and CM-QS600 modules. It is a building block in the SBC-T43 single board
> > computer, which consists of cm-t43 on top of sb-som-t43.
> > 
> > Signed-off-by: Nikita Kiryanov <nikita@compulab.co.il>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Igor Grinberg <grinberg@compulab.co.il>
> > Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>
> > Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> > ---
> >  .../devicetree/bindings/arm/compulab-boards.txt    |  5 +++
> >  .../bindings/display/panel/startek,startek-kd050c  |  4 +++
> 
> .txt please.

Right, will V2..

> 
> >  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
> >  arch/arm/boot/dts/compulab-sb-som.dtsi             | 42 ++++++++++++++++++++++
> >  4 files changed, 52 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/compulab-boards.txt
> >  create mode 100644 Documentation/devicetree/bindings/display/panel/startek,startek-kd050c
> >  create mode 100644 arch/arm/boot/dts/compulab-sb-som.dtsi
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/compulab-boards.txt b/Documentation/devicetree/bindings/arm/compulab-boards.txt
> > new file mode 100644
> > index 0000000..3e742a5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/compulab-boards.txt
> > @@ -0,0 +1,5 @@
> > +CompuLab SB-SOM is a multi-module baseboard capable of carrying CM-T43, CM-T54,
> > +and QS-600 modules with minor modifications to the SB-SOM assembly.
> 
> All these modules have compatible strings?

Yes, although they are currently undocumented. QS-600 should be CM-QS600
though.. Will fix in V2.

> 
> > +
> > +Required root node properties:
> > +    - compatible = should be "compulab,sb-som"
> > diff --git a/Documentation/devicetree/bindings/display/panel/startek,startek-kd050c b/Documentation/devicetree/bindings/display/panel/startek,startek-kd050c
> > new file mode 100644
> > index 0000000..70cd8d1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/panel/startek,startek-kd050c
> > @@ -0,0 +1,4 @@
> > +Startek Electronic Technology Co. KD050C 5.0" WVGA TFT LCD panel
> > +
> > +Required properties:
> > +- compatible: should be "startek,startek-kd050c"
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > index 55df1d4..409b134 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > @@ -218,6 +218,7 @@ sony	Sony Corporation
> >  spansion	Spansion Inc.
> >  sprd	Spreadtrum Communications Inc.
> >  st	STMicroelectronics
> > +startek	Startek
> >  ste	ST-Ericsson
> >  stericsson	ST-Ericsson
> >  synology	Synology, Inc.
> > diff --git a/arch/arm/boot/dts/compulab-sb-som.dtsi b/arch/arm/boot/dts/compulab-sb-som.dtsi
> > new file mode 100644
> > index 0000000..402a143
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/compulab-sb-som.dtsi
> > @@ -0,0 +1,42 @@
> > +/*
> > + * Copyright (C) 2015 CompuLab, Ltd. - http://www.compulab.co.il/
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +/ {
> > +	model = "CompuLab SB-SOM";
> > +	compatible = "compulab,sb-som";
> 
> I would expect this to have a more specific.

SB-SOM supports multiple modules. This device tree aggregates what is
common to all possible module-baseboard combinations, which is why the
compatible string is generic.

> 
> > +	lcd0: display {
> > +		compatible = "startek,startek-kd050c", "panel-dpi";
> > +		label = "lcd";
> 
> This isn't documented, nor do I think it is needed.

It is documented in Documentation/devicetree/bindings/display/panel/panel-dpi.txt
You're correct about it being optional though.

> 
> Rob
> 
