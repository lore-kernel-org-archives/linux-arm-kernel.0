From: padma.kvr@gmail.com (padma venkat)
Date: Wed, 28 Sep 2011 09:55:24 +0530
Subject: [PATCH 2/7] ARM: SAMSUNG: Add CLK Macro for clkdev support
In-Reply-To: <20110923202606.GT17169@n2100.arm.linux.org.uk>
References: <1316778827-24694-1-git-send-email-padma.v@samsung.com>
	<1316778827-24694-3-git-send-email-padma.v@samsung.com>
	<20110923202606.GT17169@n2100.arm.linux.org.uk>
Message-ID: <CAAgF-Bdf59wBWqj43FhB9m3Oo9ZFyMEA1yfAf7b3_qnbARNLfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Sat, Sep 24, 2011 at 1:56 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> On Fri, Sep 23, 2011 at 05:23:42PM +0530, Padmavathi Venna wrote:
> > diff --git a/arch/arm/plat-samsung/include/plat/clock.h b/arch/arm/plat-samsung/include/plat/clock.h
> > index 73c66d4..c864825 100644
> > --- a/arch/arm/plat-samsung/include/plat/clock.h
> > +++ b/arch/arm/plat-samsung/include/plat/clock.h
> > @@ -17,6 +17,13 @@
> >
> > ?struct clk;
> >
> > +#define CLK(dev, con, ck) ? ?\
> > + ? ? { ? ? ? ? ? ? ? ? ? ? ? \
> > + ? ? ? ? ? ? .dev_id = dev, ?\
> > + ? ? ? ? ? ? .con_id = con, ?\
> > + ? ? ? ? ? ? .clk = ck, ? ? ?\
> > + ? ? }
> > +
>
> How about a patch series which moves this to include/linux/clkdev.h,
> preferably called CLKDEV_INIT() ?
>
   Thanks for the review. I am currently working on preparing the patch series
   as per your suggestion.

> There's versions of this already in:
> arch/arm/mach-ux500/clock.h
> arch/arm/mach-tegra/tegra2_clocks.c
> arch/arm/mach-nomadik/clock.c
> arch/arm/mach-davinci/clock.h
>
> so let's have it standardized instead of everyone inventing their own.
>
> (Remember, that's what we're supposed to already being looking out for
> since Linus' whinge about how ARM stuff tends to grow out of control...)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html

Best Regards
Padma
