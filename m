From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 15 Jan 2016 15:46:47 -0800
Subject: [PATCH] clk: xgene: Add SoC and PMD PLL clocks with v2 hardware
In-Reply-To: <1450316255-9372-1-git-send-email-lho@apm.com>
References: <1450316255-9372-1-git-send-email-lho@apm.com>
Message-ID: <20160115234647.GT22188@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/16, Loc Ho wrote:
> @@ -41,6 +44,14 @@
>  
>  static DEFINE_SPINLOCK(clk_lock);
>  
> +static int xgene_clk_version(void)
> +{
> +	#define MIDR_EL1_VARIANT_MASK	0x00f00000
> +	u32 val = read_cpuid_id();
> +
> +	return (val & MIDR_EL1_VARIANT_MASK) == 0 ? 1 : 2;
> +}

This is very odd. It means that this file can't be test compiled
on non-arm64 platforms. It would be better to express the v1 vs.
v2 difference through DT compatible strings so that the driver
doesn't rely on reading the midr.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
