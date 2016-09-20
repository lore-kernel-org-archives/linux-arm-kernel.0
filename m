From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 20 Sep 2016 10:36:46 -0700
Subject: [PATCH 2/2] clk: imx31: properly init clocks for machines with DT
In-Reply-To: <1474252939-12579-3-git-send-email-vz@mleia.com>
References: <1474252939-12579-1-git-send-email-vz@mleia.com>
 <1474252939-12579-3-git-send-email-vz@mleia.com>
Message-ID: <20160920173646.GC8319@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19, Vladimir Zapolskiy wrote:
> @@ -222,22 +215,31 @@ int __init mx31_clocks_init(unsigned long fref)
>  	return 0;
>  }
>  
> -int __init mx31_clocks_init_dt(void)
> +static void __init mx31_clocks_init_dt(struct device_node *np)

Alternatively we can leave mx31_clocks_init_dt() around as an
exported API, but make it return 0 immediately in the same patch
to the clk driver here. Then after rc1 we can delete the "unused"
function in the clk tree assuming the last caller has been
deleted through arm-soc.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
