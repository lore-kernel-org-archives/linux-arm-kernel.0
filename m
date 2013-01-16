From: sangsu4u.park@samsung.com (Sangsu Park)
Date: Wed, 16 Jan 2013 10:08:06 +0900
Subject: [PATCH] ARM: EXYNOS: Remove wrong I2S0 clock from peril clock
In-Reply-To: <50F4CDA5.3090904@linaro.org>
References: <003501cd9d65$9611d060$c2357120$@samsung.com>
 <50F4CDA5.3090904@linaro.org>
Message-ID: <00fb01cdf385$f116dde0$d34499a0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 1/15/2013 12:32 PM, Tushar Behera wrote: 
> On 09/28/2012 04:09 PM, Sangsu Park wrote:
> > Remove I2S0 clock from peril since peril doesn't have I2S0 clock for
EXYNOS4.
> > Audio Subsystem block has I2S0 clk.
> >
> > Signed-off-by: sangsu <sangsu@sangsu-P560.(none)>
> > ---
> >  arch/arm/mach-exynos/clock-exynos4.c |    5 -----
> >  1 file changed, 5 deletions(-)
> >
> > diff --git a/arch/arm/mach-exynos/clock-exynos4.c
> > b/arch/arm/mach-exynos/clock-exynos4.c
> > index 6a45c9a..fa8a134 100644
> > --- a/arch/arm/mach-exynos/clock-exynos4.c
> > +++ b/arch/arm/mach-exynos/clock-exynos4.c
> > @@ -613,11 +613,6 @@ static struct clk exynos4_init_clocks_off[] = {
> >  		.ctrlbit	= (1 << 18),
> >  	}, {
> >  		.name		= "iis",
> > -		.devname	= "samsung-i2s.0",
> > -		.enable		= exynos4_clk_ip_peril_ctrl,
> > -		.ctrlbit	= (1 << 19),
> > -	}, {
> > -		.name		= "iis",
> >  		.devname	= "samsung-i2s.1",
> >  		.enable		= exynos4_clk_ip_peril_ctrl,
> >  		.ctrlbit	= (1 << 20),
> >
> 
> After this clock has been removed, I2S0 registration fails on EXYNOS4
> based boards (clk_get for iis clock fails). The alternate clock from
> Audio subsystem block is missing.
> 
Yes, you're right.
I2S0 clock doesn't belong to peril clock.
Audio Subsystem has its own clock and also I2S0 clock.
That work might be missed. I'll do that work soon.

Thanks.
> --
> Tushar Behera
