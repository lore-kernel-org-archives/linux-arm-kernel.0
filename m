From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 2 May 2012 18:37:48 +0800
Subject: [PATCH 11/11] ARM: dts: imx6q-sabrelite: add sound device
 imx6q-sabrelite-sgtl5000
In-Reply-To: <20120501125512.GG2194@S2101-09.ap.freescale.net>
References: <1335510185-7906-1-git-send-email-richard.zhao@freescale.com>
 <1335510185-7906-12-git-send-email-richard.zhao@freescale.com>
 <20120501125512.GG2194@S2101-09.ap.freescale.net>
Message-ID: <20120502103747.GB2982@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 01, 2012 at 08:55:14PM +0800, Shawn Guo wrote:
> On Fri, Apr 27, 2012 at 03:03:05PM +0800, Richard Zhao wrote:
> > From: Richard Zhao <richard.zhao@linaro.org>
> > 
> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > ---
> >  arch/arm/boot/dts/imx6q-sabrelite.dts |   13 +++++++++++++
> >  1 files changed, 13 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> > index cdae2dd..20aa767 100644
> > --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> > +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> > @@ -97,4 +97,17 @@
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
> 
> Just curious if you have capture working without enabling Mic Bias
> power supplier.
I should add a "Mic Jack", "Mic Bias". When arecord, mic_bias_event
is called.
It's strange that it can not record any voice. debugging ...

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
