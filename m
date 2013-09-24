From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 24 Sep 2013 12:41:09 +0200
Subject: [PATCH] ARM: EXYNOS: fix PL330 MDMA1 address in DT for Universal
 C210 board
In-Reply-To: <000001ceb912$2df4a240$89dde6c0$%kim@samsung.com>
References: <8667689.9TcYbn9cHO@amdc1032> <5328103.I4Op9muCR3@amdc1032>
 <000001ceb912$2df4a240$89dde6c0$%kim@samsung.com>
Message-ID: <6623559.ohkzlhvA2o@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Tuesday, September 24, 2013 07:38:13 PM Kukjin Kim wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > 
> > 
> > Hi Kukjin,
> > 
> Hi Bart,
> 
> > Could you please apply this patch?
> > 
> Can you make sure there is no rev1 for universal c210 board?

Universal C210 always used Exynos4210 rev0.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> - Kukjin
> 
> > Best regards,
> > --
> > Bartlomiej Zolnierkiewicz
> > Samsung R&D Institute Poland
> > Samsung Electronics
> > 
> > On Tuesday, August 20, 2013 01:22:45 PM Bartlomiej Zolnierkiewicz wrote:
> > > Revision 0 of Exynos4210 SoC (used on Universal C210 board) requires
> > > 'secure' PL330 MDMA1 address (0x12840000) instead of 'non-secure' one
> > > (0x12850000). Fix it by overriding the default PL330 MDMA1 address in
> > > exynos4210-universal_c210.dts.
> > >
> > > This is a Device Tree (DT) version of commit 91280e7 ("ARM: EXYNOS:
> > > PL330 MDMA1 fix for revision 0 of Exynos4210 SOC") and fixes recent
> > > regression caused by conversion to DT-only setup on ARM EXYNOS.
> > >
> > > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > > ---
> > >  arch/arm/boot/dts/exynos4210-universal_c210.dts | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> > b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> > > index 889cdad..d2e3f5f 100644
> > > --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> > > +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> > > @@ -350,3 +350,7 @@
> > >  		status = "okay";
> > >  	};
> > >  };
> > > +
> > > +&mdma1 {
> > > +	reg = <0x12840000 0x1000>;
> > > +};
