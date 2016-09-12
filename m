From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 12 Sep 2016 20:18:00 +0800
Subject: [PATCH v4 2/3] arm64: dts: Add ZTE ZX296718 SoC dts and Makefile
In-Reply-To: <20160909115336.GB16924@tiger>
References: <1473141861-5033-1-git-send-email-jun.nie@linaro.org>
 <1473141861-5033-3-git-send-email-jun.nie@linaro.org>
 <20160909115336.GB16924@tiger>
Message-ID: <20160912121800.GB7373@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2016 at 07:53:36PM +0800, Shawn Guo wrote:
> A bit more comments as below ...
> 
> On Tue, Sep 06, 2016 at 02:04:20PM +0800, Jun Nie wrote:
> > +	soc {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		compatible = "simple-bus";
> > +		interrupt-parent = <&gic>;
> > +		ranges;
> > +
> > +		timer {
> > +			compatible = "arm,armv8-timer";
> > +			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> > +				     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> > +				     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> > +				     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> 
> Affinity bits are missing for PPI interrupt.  You can use a bit help
> from defines in include/dt-bindings/interrupt-controller/arm-gic.h.

Sorry, I missed the fact that affinity bits is only required for gic-v2,
while what we have here is a gic-v3.  So please ignore the comment.

Shawn
