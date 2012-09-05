From: marex@denx.de (Marek Vasut)
Date: Wed, 5 Sep 2012 04:57:03 +0200
Subject: [PATCH] arm: mxs: Fix MMC WP pin being inverted
In-Reply-To: <20120905024046.GR2362@S2101-09.ap.freescale.net>
References: <1346811082-27295-1-git-send-email-marex@denx.de>
 <20120905024046.GR2362@S2101-09.ap.freescale.net>
Message-ID: <201209050457.03707.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> Please resend with subject "arm: " changing to "ARM: ", or even better
> the one below.
> 
>   ARM: dts: m28evk: ...

I really don't like this game ...

> 
> On Wed, Sep 05, 2012 at 04:11:22AM +0200, Marek Vasut wrote:
> > The MMC WP is active high on the m28evk, fix this.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > ---
> > 
> >  arch/arm/boot/dts/imx28-m28evk.dts |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx28-m28evk.dts
> > b/arch/arm/boot/dts/imx28-m28evk.dts index 845bb42..10868f1 100644
> > --- a/arch/arm/boot/dts/imx28-m28evk.dts
> > +++ b/arch/arm/boot/dts/imx28-m28evk.dts
> > @@ -63,7 +63,7 @@
> > 
> >  					     &mmc0_cd_cfg
> >  					     &mmc0_sck_cfg>;
> >  				
> >  				bus-width = <8>;
> > 
> > -				wp-gpios = <&gpio3 10 1>;
> > +				wp-gpios = <&gpio3 10 0>;
> > 
> >  				vmmc-supply = <&reg_vddio_sd0>;
> >  				status = "okay";
> >  			
> >  			};

Best regards,
Marek Vasut
