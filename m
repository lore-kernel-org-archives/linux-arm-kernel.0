From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 4 Sep 2013 15:08:44 +0100
Subject: [PATCH 02/11] ARM: ux500: Enable the LPS001WP Pressure &
 Temperature sensor from DT
In-Reply-To: <20130904133654.GH20150@lee--X1>
References: <1378287103-21765-1-git-send-email-lee.jones@linaro.org>
 <1378287103-21765-3-git-send-email-lee.jones@linaro.org>
 <20130904123850.GI18206@e106331-lin.cambridge.arm.com>
 <20130904133654.GH20150@lee--X1>
Message-ID: <20130904140844.GL18206@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 04, 2013 at 02:36:54PM +0100, Lee Jones wrote:
> On Wed, 04 Sep 2013, Mark Rutland wrote:
> 
> > Hi Lee,
> > 
> > On Wed, Sep 04, 2013 at 10:31:34AM +0100, Lee Jones wrote:
> > > After applying this node the LPS001WP sensor chip should probe
> > > successfully once the driver support has also been applied.
> > > 
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  arch/arm/boot/dts/ste-snowball.dts | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
> > > index cf9b16e..aad8f54 100644
> > > --- a/arch/arm/boot/dts/ste-snowball.dts
> > > +++ b/arch/arm/boot/dts/ste-snowball.dts
> > > @@ -153,6 +153,16 @@
> > >  			status = "okay";
> > >  		};
> > >  
> > > +		i2c at 80128000 {
> > > +			lps001wp at 5c {
> > > +				compatible = "lps001wp";
> > > +				reg = <0x5c>;
> > > +
> > > +				vdd-supply = <&ab8500_ldo_aux1_reg>;
> > > +				vms-supply = <&db8500_vsmps2_reg>;
> > > +			};
> > > +		};
> > > +
> > 
> > This appears to be missing a binding document. I couldn't see one
> > anywhere in this series, or in mainline already).
> > 
> > As far as I can see, the compatible string should be "st,lps001wp".
> 
> The I2C subsystem doesn't actually care about vendor prefixes. They
> are all stripped before use in all cases. However, I'm happy to
> provide one if for no other reason than to stick to convention.

I'd prefer if we did document this. Just because Linux doesn't care
about this at the moment doesn't mean we (or another OS) might want to
handle it differently in future. It also gives us a semblance of
consistency.

> 
> > Please produce a binding document.
> 
> Again, I'm happy to provide a boilerplate document, but there's
> nothing special happening here.

That's not true. The names of the regulators should be documented. One
seems to be optional for some reason.

> 
> > Is there any publicly available documentation on the chip?
> 
> If you Google the device name, it will be the first hit.

Ok, I'll take a look.

> 
> > >  		uart at 80120000 {
> > >  			status = "okay";
> > >  		};
> 
> Kind regards,
> Lee

Cheers,
Mark.
