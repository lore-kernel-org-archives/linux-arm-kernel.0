From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 11 Apr 2017 13:28:22 +0530
Subject: [PATCH 3/5] cpufreq: dt: Add support for some new Allwinner SoCs
In-Reply-To: <20170411071911.1A8EF203634@relay.mailchannels.net>
References: <20170411071911.1A8EF203634@relay.mailchannels.net>
Message-ID: <20170411075822.GA13627@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-04-17, 15:18, Icenowy Zheng wrote:
> 
> 2017?4?11? 15:03? Viresh Kumar <viresh.kumar@linaro.org>???
> >
> > On Sun, Apr 9, 2017 at 12:20 AM, Icenowy Zheng <icenowy@aosc.io> wrote: 
> > > Some new Allwinner SoCs get supported in the kernel after the 
> > > compatibles are added to cpufreq-dt-platdev driver. 
> > > 
> > > Add their compatible strings in the cpufreq-dt-platdev driver. 
> > > 
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.io> 
> > > --- 
> > >? drivers/cpufreq/cpufreq-dt-platdev.c | 5 +++++ 
> > >? 1 file changed, 5 insertions(+) 
> > > 
> > > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c 
> > > index 921b4a6c3d16..2180e509e383 100644 
> > > --- a/drivers/cpufreq/cpufreq-dt-platdev.c 
> > > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c 
> > > @@ -24,7 +24,12 @@ static const struct of_device_id machines[] __initconst = { 
> > >???????? { .compatible = "allwinner,sun8i-a23", }, 
> > >???????? { .compatible = "allwinner,sun8i-a33", }, 
> > >???????? { .compatible = "allwinner,sun8i-a83t", }, 
> > > +?????? { .compatible = "allwinner,sun8i-h2-plus", }, 
> > >???????? { .compatible = "allwinner,sun8i-h3", }, 
> > > +?????? { .compatible = "allwinner,sun8i-v3s", }, 
> > > +?????? { .compatible = "allwinner,sun50i-a64", }, 
> > > +?????? { .compatible = "allwinner,sun50i-h5", }, 
> > > +?????? { .compatible = "nextthing,gr8", }, 
> >
> >
> > This needs to be in alphabetical order and please cc cpufreq 
> 
> However I prefer these sequence -- sun50i is later than sun8i.
> 
> Place sun50i between sun4i and sun5i is meaningless, as sun50i in fact have a deep relationship with sun8i, but not sun4/5i.

We aren't really worried about relationship here. The order is important to find
missing entries as soon as possible and that's why I have been forcing people to
add entries in alphabetical order.

-- 
viresh
