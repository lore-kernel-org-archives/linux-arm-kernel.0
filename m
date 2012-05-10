From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 10 May 2012 17:34:45 +0800
Subject: [PATCH V2 08/11] ARM: dts: imx6q-sabrelite: add sound device
 imx6q-sabrelite-sgtl5000
In-Reply-To: <20120510064816.GC17875@S2101-09.ap.freescale.net>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-9-git-send-email-richard.zhao@freescale.com>
 <20120510064816.GC17875@S2101-09.ap.freescale.net>
Message-ID: <20120510093444.GI2982@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 02:48:19PM +0800, Shawn Guo wrote:
> On Wed, May 09, 2012 at 07:33:07PM +0800, Richard Zhao wrote:
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > ---
> >  arch/arm/boot/dts/imx6q-sabrelite.dts |   14 ++++++++++++++
> >  1 files changed, 14 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> > index 5b51deb..5a35bfd 100644
> > --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> > +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> > @@ -110,4 +110,18 @@
> >  			regulator-always-on;
> >  		};
> >  	};
> > +
> > +	sound {
> > +		compatible = "fsl,imx6q-sabrelite-sgtl5000",
> > +			     "fsl,imx-audio-sgtl5000";
> > +		model = "imx6q-sabrelite-sgtl5000";
> > +		ssi-controller = <&ssi1>;
> > +		audio-codec = <&codec>;
> > +		audio-routing =
> > +			"MIC_IN", "Mic Jack",
> > +			"Mic Jack", "Mic Bias",
> 
> "Mic Bias" is a SUPPLY for both "MIC_IN" and "Mic Jack", so it should
> look like:
> 
>                        "Mic Jack", "Mic Bias",
>                        "MIC_IN", "Mic Bias",
Not really. The circuit:
MIC_IN <-- capacitor <--> Mic Jack
                      /
            Mic Bias /

DC can not pass the capacitor. So Mic Bias only supply Jack.

Thanks
Richard

> 
> Regards,
> Shawn
> 
> > +			"Headphone Jack", "HP_OUT";
> > +		mux-int-port = <1>;
> > +		mux-ext-port = <4>;
> > +	};
> >  };
> > -- 
> > 1.7.5.4
> > 
> > 
> 
