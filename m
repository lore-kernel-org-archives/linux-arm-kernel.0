From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Jun 2010 23:07:17 +0100
Subject: [RFC PATCH] msm: initial MSM8X60 early kernel boot support
In-Reply-To: <1277157793-9712-1-git-send-email-dwalker@codeaurora.org>
References: <1277156422-9130-1-git-send-email-dwalker@codeaurora.org>
	<1277157793-9712-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <20100621220716.GD13624@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 21, 2010 at 03:03:13PM -0700, Daniel Walker wrote:
> +int boot_secondary(unsigned int cpu, struct task_struct *idle)
> +{
> +	int cnt = 0;
> +	printk(KERN_DEBUG "Starting secondary CPU %d\n", cpu);
> +
> +	/* Tell other CPUs to come out or reset.  Note that secondary CPUs
> +	 * are probably running with caches off, so we'll need to clean to
> +	 * memory. Normal cache ops will only clean to L2.
> +	 */
> +	pen_release = cpu;
> +	dmac_clean_range((void *)&pen_release,
> +			 (void *)(&pen_release + sizeof(pen_release)));

dmac_clean_range() and dmac_inv_range() no longer exist.

> +	dmac_clean_range((void *)&secondary_data,
> +			 (void *)(&secondary_data + sizeof(secondary_data)));

We've already fixed this.
