From: joe@perches.com (Joe Perches)
Date: Mon, 08 Nov 2010 09:39:43 -0800
Subject: [PATCH] arch/arm/plat-mxc/cpufreq.c: Fix line continuation defect
In-Reply-To: <20101108081808.GN16938@pengutronix.de>
References: <1289164215.29216.315.camel@Joe-Laptop>
	<20101108081808.GN16938@pengutronix.de>
Message-ID: <1289237983.29216.340.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-11-08 at 09:18 +0100, Uwe Kleine-K?nig wrote:
> On Sun, Nov 07, 2010 at 01:10:15PM -0800, Joe Perches wrote:
> > diff --git a/arch/arm/plat-mxc/cpufreq.c b/arch/arm/plat-mxc/cpufreq.c
[]
> > -		printk(KERN_ERR "%s: failed to register i.MXC CPUfreq \
> > -				with error code %d\n", __func__, ret);
> > +		printk(KERN_ERR "%s: failed to register i.MXC CPUfreq with error code %d\n",
> > +		       __func__, ret);
> I'd prefer
> +		printk(KERN_ERR "%s: failed to register i.MXC CPUfreq "
> +				"with error code %d\n", __func__, ret);
> (actually I'd consider
> +		pr_err("failed to register i.MXC CPUfreq (error: %d)\n", ret)
> even better, but this is out of scope for this patch, isn't it?)

Yes, it's out of scope.

I do have a perl & emacs script that converts
printk(KERN_<level> to pr_<level>, coalesces formats,
and wraps/aligns arguments.

It's around 2K lines of changes though for arch/arm.

Anyone want that all at once or by platform by platform?
