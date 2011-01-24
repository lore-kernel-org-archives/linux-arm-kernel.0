From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 10:26:47 +0000
Subject: [PATCH v2 28/28] ARM: tegra: clock: Add forward reference to
	struct clk
In-Reply-To: <1295834493-5019-29-git-send-email-ccross@android.com>
References: <1295834493-5019-1-git-send-email-ccross@android.com>
	<1295834493-5019-29-git-send-email-ccross@android.com>
Message-ID: <20110124102647.GF16202@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 23, 2011 at 06:01:33PM -0800, Colin Cross wrote:
> diff --git a/arch/arm/mach-tegra/include/mach/clkdev.h b/arch/arm/mach-tegra/include/mach/clkdev.h
> index 412f5c6..66cd3f4 100644
> --- a/arch/arm/mach-tegra/include/mach/clkdev.h
> +++ b/arch/arm/mach-tegra/include/mach/clkdev.h
> @@ -20,6 +20,8 @@
>  #ifndef __MACH_CLKDEV_H
>  #define __MACH_CLKDEV_H
>  
> +struct clk;
> +
>  static inline int __clk_get(struct clk *clk)
>  {
>  	return 1;

If you're having to add that, I suspect this include is being
inappropriately included by files.
