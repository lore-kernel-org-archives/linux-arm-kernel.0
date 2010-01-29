From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Jan 2010 14:14:07 +0000
Subject: [RFC PATCH 04/12] arm: mm: cache-l2x0: add l2x0 suspend and
	resume functions
In-Reply-To: <1264719577-5436-5-git-send-email-dwalker@codeaurora.org>
References: <1264719577-5436-5-git-send-email-dwalker@codeaurora.org>
Message-ID: <20100129141407.GA16712@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static inline void l2x0_flush_all(void)
> +{
> +	/* clean and invalidate all ways */
> +	sync_writel(0xff, L2X0_CLEAN_INV_WAY, 0xff);
> +	cache_sync();
> +}

Note that this patch is out of date; it won't apply to current kernels
and build.
