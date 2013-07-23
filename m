From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 23 Jul 2013 11:32:43 +0200
Subject: [PATCH 07/22] ARM: exynos: Remove '0x's from Exynos4110 DTSI file
In-Reply-To: <20130723085552.GF26801@laptop>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <2350088.9z671SCjFz@flatron> <20130723085552.GF26801@laptop>
Message-ID: <1610492.3P9vcH2Wcz@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 of July 2013 09:55:52 Lee Jones wrote:
> On Mon, 22 Jul 2013, Tomasz Figa wrote:
> > Hi Lee,
> > 
> > On Monday 22 of July 2013 11:52:26 Lee Jones wrote:
> > > Cc: Kukjin Kim <kgene.kim@samsung.com>
> > > Cc: linux-samsung-soc at vger.kernel.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > > 
> > >  arch/arm/boot/dts/exynos4210.dtsi | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/exynos4210.dtsi
> > > b/arch/arm/boot/dts/exynos4210.dtsi index b7f358a..53e2527 100644
> > > --- a/arch/arm/boot/dts/exynos4210.dtsi
> > > +++ b/arch/arm/boot/dts/exynos4210.dtsi
> > > @@ -72,7 +72,7 @@
> > > 
> > >  		};
> > >  	
> > >  	};
> > > 
> > > -	clock: clock-controller at 0x10030000 {
> > > +	clock: clock-controller at 10030000 {
> > > 
> > >  		compatible = "samsung,exynos4210-clock";
> > >  		reg = <0x10030000 0x20000>;
> > >  		#clock-cells = <1>;
> > 
> > This looks fine, but please fix commit message - it should be
> > Exynos4210. Also some explanation why this change is needed would be
> > good, even if it's obvious.
> 
> Hi Tomasz,
> 
> I'm happy to fixup the $SUBJECT line, but do we really have to enter
> an explanation if it's obvious? Seems a little belt and braces.

It's obvious for us, people working with device tree, but for people that 
usually don't it might not be.

Something among following lines would be fine:

This patch removes "0x" prefix from addresses in DT nodes for the sake of 
consistency with other nodes and assumed convention.

Best regards,
Tomasz
