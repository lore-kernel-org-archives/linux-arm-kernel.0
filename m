From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 7 Oct 2011 10:22:43 +0100
Subject: [PATCH v3] omap: dmtimer: convert printk to pr_err
In-Reply-To: <1317977417-17874-1-git-send-email-vjaquez@igalia.com>
References: <20111006201827.GT6324@atomide.com>
	<1317977417-17874-1-git-send-email-vjaquez@igalia.com>
Message-ID: <20111007092243.GC27281@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 07, 2011 at 10:50:16AM +0200, V?ctor Manuel J?quez Leal wrote:
> Convert a printk(KERN_ERR) message in the driver to pr_err().
...
> @@ -111,7 +111,7 @@ static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
>  	while (!(__raw_readl(timer->sys_stat) & 1)) {
>  		c++;
>  		if (c > 100000) {
> -			printk(KERN_ERR "Timer failed to reset\n");
> +			pr_err("Timer failed to reset\n");

What is the reason behind this change?  It looks like it's to use the
latest and greatest function.

If so, please don't make these changes - we have on many occasions been
blamed for size of diffstat, churn, needless change, and this patch is
exactly that.

By all means fix printk's without KERN_ constants, possibly converting
them to pr_*, but don't go around replacing printk(KERN_* with pr_*(
without ensuring that there's a real benefit to the change.
