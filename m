From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 4 Sep 2013 14:51:43 +0100
Subject: [PATCH 02/11] ARM: ux500: Enable the LPS001WP Pressure &
 Temperature sensor from DT
In-Reply-To: <20130904123850.GI18206@e106331-lin.cambridge.arm.com>
References: <1378287103-21765-1-git-send-email-lee.jones@linaro.org>
 <1378287103-21765-3-git-send-email-lee.jones@linaro.org>
 <20130904123850.GI18206@e106331-lin.cambridge.arm.com>
Message-ID: <20130904135143.GJ20150@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 04 Sep 2013, Mark Rutland wrote:

> Hi Lee,
> 
> On Wed, Sep 04, 2013 at 10:31:34AM +0100, Lee Jones wrote:
> > After applying this node the LPS001WP sensor chip should probe
> > successfully once the driver support has also been applied.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  arch/arm/boot/dts/ste-snowball.dts | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
> > index cf9b16e..aad8f54 100644
> > --- a/arch/arm/boot/dts/ste-snowball.dts
> > +++ b/arch/arm/boot/dts/ste-snowball.dts
> > @@ -153,6 +153,16 @@
> >  			status = "okay";
> >  		};
> >  
> > +		i2c at 80128000 {
> > +			lps001wp at 5c {
> > +				compatible = "lps001wp";
> > +				reg = <0x5c>;
> > +
> > +				vdd-supply = <&ab8500_ldo_aux1_reg>;
> > +				vms-supply = <&db8500_vsmps2_reg>;
> > +			};
> > +		};
> > +
> 
> This appears to be missing a binding document. I couldn't see one
> anywhere in this series, or in mainline already).
> 
> As far as I can see, the compatible string should be "st,lps001wp".
> 
> Please produce a binding document.

Patch sent, most of you are on CC.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
