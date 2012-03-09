From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 9 Mar 2012 10:55:46 +0100
Subject: [PATCH 2/5 v3] ARM: at91: sam9g20 add i2c DT support
In-Reply-To: <20120309052600.B13BA3E0649@localhost>
References: <1331196635-27203-1-git-send-email-plagnioj@jcrosoft.com>
 <1331196635-27203-2-git-send-email-plagnioj@jcrosoft.com>
 <20120309052600.B13BA3E0649@localhost>
Message-ID: <20120309095546.GL27213@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22:26 Thu 08 Mar     , Grant Likely wrote:
> On Thu,  8 Mar 2012 09:50:32 +0100, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> wrote:
> > For now on use i2c-gpio driver on the same pin as the hardware IP.
> > 
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Cc: devicetree-discuss at lists.ozlabs.org
> > ---
> > v3:
> > 
> > 	update i2c binding (Rob comments)
> > 
> > Best Regards,
> > J.
> >  arch/arm/boot/dts/at91sam9g20.dtsi |   13 +++++++++++++
> >  1 files changed, 13 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
> > index 4b0dc99..072b2da 100644
> > --- a/arch/arm/boot/dts/at91sam9g20.dtsi
> > +++ b/arch/arm/boot/dts/at91sam9g20.dtsi
> > @@ -189,4 +189,17 @@
> >  			status = "disabled";
> >  		};
> >  	};
> > +
> > +	i2c-gpio at 0 {
> 
> i2c at 0
> 
> > +		compatible = "i2c-gpio";
> > +		gpios = <&pioA 23 0 /* sda */
> > +			 &pioA 24 0 /* scl */
> > +			>;
> > +		i2c-gpio,sda-open-drain;
> > +		i2c-gpio,scl-open-drain;
> > +		i2c-gpio,delay-us = <2>;	/* ~100 kHz */
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		status = "disabled";
> > +	};
> 
> gpio-driven i2c busses are inherently board-specific.  Why is this
> in the SoC include file?
because they use the hw pin and all board will use the same as on some soc
(old) we can not use the hw IP
> 
> Otherwise I think this patch series looks okay.

Best Regards,
J.
