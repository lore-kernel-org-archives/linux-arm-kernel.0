From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 06 Jun 2013 10:41:29 +0900
Subject: [PATCH V2 2/2] ARM: dts: add dts node for the ahci sata exynos5440
References: <1366104611-14315-1-git-send-email-ks.giri@samsung.com>
Message-ID: <09d301ce6256$f7771890$e66549b0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> Girish K S wrote:
> >
> > This patch adds dts support for the sata controller
> >
> > Signed-off-by: Girish K S <ks.giri@samsung.com>
> > ---
> >  arch/arm/boot/dts/exynos5440.dtsi |    9 +++++++++
> >  1 files changed, 9 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
> > index 7c5dc38..2dc4ffa 100644
> > --- a/arch/arm/boot/dts/exynos5440.dtsi
> > +++ b/arch/arm/boot/dts/exynos5440.dtsi
> > @@ -220,4 +220,13 @@
> >  		clock-names = "rtc";
> >  		status = "disabled";
> >  	};
> > +
> > +	sata at 210000 {
> > +		compatible = "snps,exynos5440-ahci";
> > +		reg = <0x210000 0x10000>;
> > +		interrupts = <0 30 0>;
> > +		clocks = <&clock 10>;

Oops, this should be

+		clocks = <&clock 23>;

Applied with fixing.

Thanks.

- Kukjin
