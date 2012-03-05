From: lost.distance@yahoo.com (Paul Parsons)
Date: Mon, 5 Mar 2012 22:48:37 +0000 (GMT)
Subject: Status of gpio-pxa driver and dummy clock
In-Reply-To: <87399mu2dn.fsf@free.fr>
Message-ID: <1330987717.23600.YahooMailClassic@web29008.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--- On Mon, 5/3/12, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Date: Monday, 5 March, 2012, 22:08
> Haojian Zhuang <haojian.zhuang@gmail.com>
> writes:
> 
> > I missed them. Maybe I was not in the Cc list. I'll
> append the patches
> > to fix them.
> 
> Just to be sure, this is the patch which is missing for the
> dummy clock, which
> was not submitted before AFAIK (Jonathan, Paul, please
> confirm).
> 
> I added the commit text to Paul's patch, and authored it as
> Paul's with
> Jonathan's report. Again, Jonathan, Paul, I'd like to have
> your agreement here.
> 
> Haojian, if you have another patch ready, don't hesitate to
> drop this patch and
> take your own, as long as gpio-pxa is fixed, I'll be happy.

I created this patch without waiting for an official fix purely to solve
the problem for myself. I then posted it in case it would be useful to
others. By all means use it or, if a better patch exists, drop it.

> Cheers.
> 
> --
> Robert
> 
> 8>----
> From 505a23475843a8fbac077e789d911ee07e1ae9cc Mon Sep 17
> 00:00:00 2001
> From: Paul Parsons <lost.distance@yahoo.com>
> Date: Sat, 3 Mar 2012 21:10:09 +0100
> Subject: [PATCH] arch/arm: pxa add dummy clocks for gpio
> driver
> 
> Fix gpio driver by providing it a dummy clock. This
> regression was introduced by the commit "ARM: pxa: add
> dummy
> clock for sa1100-rtc", id
> a55b5adaf403c4d032e0871ad4ee3367782f4db6.
> 
> Reported-by: Jonathan Cameron <jic23@cam.ac.uk>
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  arch/arm/mach-pxa/pxa25x.c |? ? 1 +
>  arch/arm/mach-pxa/pxa27x.c |? ? 1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-pxa/pxa25x.c
> b/arch/arm/mach-pxa/pxa25x.c
> index 00d6eac..d8de3e5 100644
> --- a/arch/arm/mach-pxa/pxa25x.c
> +++ b/arch/arm/mach-pxa/pxa25x.c
> @@ -208,6 +208,7 @@ static struct clk_lookup
> pxa25x_clkregs[] = {
>  ??? INIT_CLKREG(&clk_pxa25x_gpio11,
> NULL, "GPIO11_CLK"),
>  ??? INIT_CLKREG(&clk_pxa25x_gpio12,
> NULL, "GPIO12_CLK"),
>  ??? INIT_CLKREG(&clk_pxa25x_mem,
> "pxa2xx-pcmcia", NULL),
> +??? INIT_CLKREG(&clk_dummy, "pxa-gpio",
> NULL),
>  };
>  
>  static struct clk_lookup pxa25x_hwuart_clkreg =
> diff --git a/arch/arm/mach-pxa/pxa27x.c
> b/arch/arm/mach-pxa/pxa27x.c
> index c1673b3..a3fabc9 100644
> --- a/arch/arm/mach-pxa/pxa27x.c
> +++ b/arch/arm/mach-pxa/pxa27x.c
> @@ -229,6 +229,7 @@ static struct clk_lookup
> pxa27x_clkregs[] = {
>  ??? INIT_CLKREG(&clk_pxa27x_im, NULL,
> "IMCLK"),
>  ??? INIT_CLKREG(&clk_pxa27x_memc, NULL,
> "MEMCLK"),
>  ??? INIT_CLKREG(&clk_pxa27x_mem,
> "pxa2xx-pcmcia", NULL),
> +??? INIT_CLKREG(&clk_dummy, "pxa-gpio",
> NULL),
>  };
>  
>  #ifdef CONFIG_PM
> -- 
> 1.7.5.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
