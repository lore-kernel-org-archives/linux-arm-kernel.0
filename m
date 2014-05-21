From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 21 May 2014 14:30:38 +0100
Subject: [PATCH v2 4/4] ARM: dts: bcm590xx: add support for GPLDO and
 VBUS regulators
In-Reply-To: <20140521120257.GV32082@beef>
References: <1398295293-11033-1-git-send-email-mporter@linaro.org>
 <1398295293-11033-5-git-send-email-mporter@linaro.org>
 <20140521092913.GG6679@lee--X1> <20140521120257.GV32082@beef>
Message-ID: <20140521133038.GJ6679@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > diff --git a/arch/arm/boot/dts/bcm59056.dtsi b/arch/arm/boot/dts/bcm59056.dtsi
> > > index dfadaaa..066adfb 100644
> > > --- a/arch/arm/boot/dts/bcm59056.dtsi
> > > +++ b/arch/arm/boot/dts/bcm59056.dtsi
> > > @@ -70,5 +70,26 @@
> > >  
> > >  		vsr_reg: vsr {
> > >  		};
> > > +
> > > +		gpldo1_reg: gpldo1 {
> > > +		};
> > 
> > What do these empty nodes do in any case?
> 
> They instantiate regulators. The bcm590xx binding specifies the
> allowable subnode names permitted here. This replaces the old method
> of specifying an index or the deprecated regulator-compatible property.
> The board-specific dts includes this dtsi and applies any board
> constraints to a subset of regulators that need them. Unused regulators
> are all disabled which is what we want.
> 
> > Don't you at least need a status property in there or something?
> 
> Not necessary for these subnodes.

Very well, thanks for the clarification.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
