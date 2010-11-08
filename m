From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Nov 2010 09:08:03 +0000
Subject: [PATCH] arch/arm/plat-mxc/cpufreq.c: Fix line continuation defect
In-Reply-To: <20101108081808.GN16938@pengutronix.de>
References: <1289164215.29216.315.camel@Joe-Laptop>
	<20101108081808.GN16938@pengutronix.de>
Message-ID: <20101108090803.GA13157@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 08, 2010 at 09:18:08AM +0100, Uwe Kleine-K?nig wrote:
> Hi Joe,
> 
> On Sun, Nov 07, 2010 at 01:10:15PM -0800, Joe Perches wrote:
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >  arch/arm/plat-mxc/cpufreq.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/plat-mxc/cpufreq.c b/arch/arm/plat-mxc/cpufreq.c
> > index 039538e..9f358af 100644
> > --- a/arch/arm/plat-mxc/cpufreq.c
> > +++ b/arch/arm/plat-mxc/cpufreq.c
> > @@ -154,8 +154,8 @@ static int __init mxc_cpufreq_init(struct cpufreq_policy *policy)
> >  	ret = cpufreq_frequency_table_cpuinfo(policy, imx_freq_table);
> >  
> >  	if (ret < 0) {
> > -		printk(KERN_ERR "%s: failed to register i.MXC CPUfreq \
> > -				with error code %d\n", __func__, ret);
> > +		printk(KERN_ERR "%s: failed to register i.MXC CPUfreq with error code %d\n",
> > +		       __func__, ret);
> I'd prefer
> +		printk(KERN_ERR "%s: failed to register i.MXC CPUfreq "
> +				"with error code %d\n", __func__, ret);

No - you don't wrap error messages.  It's the one exception to the 80
column rule.
