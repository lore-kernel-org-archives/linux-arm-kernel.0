From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 24 Sep 2016 22:19:46 +0800
Subject: [PATCH 1/2] dt-bindings: add bindings doc for ZTE VOU display
 controller
In-Reply-To: <20160923223043.GA30909@rob-hp-laptop>
References: <1474615449-16893-1-git-send-email-shawn.guo@linaro.org>
 <20160923223043.GA30909@rob-hp-laptop>
Message-ID: <20160924141945.GD11051@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 05:30:43PM -0500, Rob Herring wrote:
> > +display-subsystem {
> > +	compatible = "zte,zx-display-subsystem";
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +	ranges;
> > +
> > +	vou: vou at 1440000 {
> > +		compatible = "zte,zx296718-vou";
> > +		reg = <0x1440000 0x10000>;
> > +		interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> > +		clocks = <&topcrm VOU_ACLK>, <&topcrm VOU_PPU_WCLK>,
> > +			 <&topcrm VOU_MAIN_WCLK>, <&topcrm VOU_AUX_WCLK>;
> > +		clock-names = "aclk", "ppu_wclk",
> > +			      "main_wclk", "aux_wclk";
> > +	};
> > +
> > +	hdmi: hdmi at 144c000 {
> > +		compatible = "zte,zx296718-hdmi";
> > +		reg = <0x144c000 0x4000>;
> 
> You have overlapping regions here. I'd suggest you kill off
> zte,zx-display-subsystem and make zte,zx296718-vou the top-level node 
> with hdmi and others as the child nodes.

I was trying to make device tree simple by defining those discrete
regions in kernel driver.  But honestly, I'm also unhappy about that
virtual top-level node.  Version 2 Will come soon with suggested
bindings.

Shawn
