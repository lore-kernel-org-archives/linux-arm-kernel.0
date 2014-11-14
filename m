From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 14 Nov 2014 10:16:18 +0100
Subject: [PATCH v3] of: replace Asahi Kasei Corp venter prefix
In-Reply-To: <5465BFA2.9050706@nvidia.com>
References: <5398AB07.4040304@wwwdotorg.org>
 <87k32yd0bd.wl%kuninori.morimoto.gx@renesas.com>
 <5465BFA2.9050706@nvidia.com>
Message-ID: <2984171.bo9yu8oQT6@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 November 2014 17:38:58 Alexandre Courbot wrote:
> > diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
> > index a1d4bf9..7f5cf80 100644
> > --- a/arch/arm/boot/dts/tegra20-seaboard.dts
> > +++ b/arch/arm/boot/dts/tegra20-seaboard.dts
> > @@ -405,7 +405,7 @@
> >               clock-frequency = <400000>;
> >
> >               magnetometer at c {
> > -                     compatible = "ak,ak8975";
> > +                     compatible = "asahi-kasei,ak8975";
> 
> Mmm. So does this mean this device was never probed because the driver 
> did not recognize its compatible property? I cannot find "ak,ak8975" 
> anywhere else in the kernel.
> 

No, the i2c bus behaves in a special way by matching the "ak8975"
i2c driver name with any "*,ak8975" DT compatible string. Both
of the above will work with existing kernels.

	Arnd
