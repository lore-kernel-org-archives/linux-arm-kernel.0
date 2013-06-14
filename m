From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 14 Jun 2013 14:41:47 +0800
Subject: [PATCH 6/9] ARM: dtsi: imx6qdl-sabresd: Add WM8962 CODEC support
In-Reply-To: <20130614062313.GA9167@MrMyself>
References: <cover.1371123426.git.b42378@freescale.com>
 <d77dd407188926f61c787eb307dd142cf0b37e1b.1371123426.git.b42378@freescale.com>
 <20130614062147.GC20513@S2101-09.ap.freescale.net>
 <20130614062313.GA9167@MrMyself>
Message-ID: <20130614064146.GF20513@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 02:23:14PM +0800, Nicolin Chen wrote:
> On Fri, Jun 14, 2013 at 02:21:49PM +0800, Shawn Guo wrote:
> > > +
> > > +	codec: wm8962 at 1a {
> > > +		compatible = "wlf,wm8962";
> > > +		reg = <0x1a>;
> > > +		clocks = <&clks 169>;
> > > +		DCVDD-supply = <&reg_audio>;	/* 1.8v */
> > > +		DBVDD-supply = <&reg_audio>;	/* 1.8v */
> > > +		AVDD-supply = <&reg_audio>;	/* 1.8v */
> > > +		CPVDD-supply = <&reg_audio>;	/* 1.8v */
> > > +		MICVDD-supply = <&reg_audio>;	/* 3.3v */
> > > +		PLLVDD-supply = <&reg_audio>;	/* 1.8v */
> > > +		SPKVDD1-supply = <&reg_audio>;	/* 4.2v */
> > > +		SPKVDD2-supply = <&reg_audio>;	/* 4.2v */
> > 
> > You comment these supplies with different voltages but they are actually
> > pointing to the same fixed regulator.
> 
> That's because they are all controlled by one GPIO pin. But you are right
> these comments might be confusing.
> 
> And I think I don't need to send a V2 any more right? Since I saw you said
> you did the fix-up for me.

I just removed the comments.

Shawn
