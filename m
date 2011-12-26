From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 26 Dec 2011 19:06:17 +0000
Subject: [PATCH 2/2] ARM: Exynos: Hook up power domains to generic power
 domain infrastructure
In-Reply-To: <1323704789-23923-3-git-send-email-thomas.abraham@linaro.org>
References: <1323704789-23923-1-git-send-email-thomas.abraham@linaro.org>
 <1323704789-23923-2-git-send-email-thomas.abraham@linaro.org>
 <1323704789-23923-3-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20111226190616.GL8722@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 09:16:29PM +0530, Thomas Abraham wrote:

> +	/* Wait max 1ms */
> +	timeout = 10;
> +	while ((__raw_readl(base + 0x4) & S5P_INT_LOCAL_PWR_EN)
> +					!= S5P_INT_LOCAL_PWR_EN) {
> +		if (!timeout) {
> +			pr_err("Power domain %s enable failed\n", domain->name);
> +			return -ETIMEDOUT;
> +		}
> +		timeout--;
> +		udelay(100);
> +	}

Might be worth putting a cpu_relax() in there just to be a bit nicer?
