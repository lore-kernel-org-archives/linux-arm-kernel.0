From: cjb@laptop.org (Chris Ball)
Date: Sat, 26 Oct 2013 22:28:19 -0400
Subject: [PATCH 2/2] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
In-Reply-To: <1382533396-6584-1-git-send-email-zhangfei.gao@linaro.org>
 (Zhangfei Gao's message of "Wed, 23 Oct 2013 21:03:16 +0800")
References: <1382339639-16764-3-git-send-email-zhangfei.gao@linaro.org>
 <1382533396-6584-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <87a9hvla64.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhangfei, just small changes,

On Wed, Oct 23 2013, Zhangfei Gao wrote:
> +* tune-table: should be array of clock tune mmc controller

This sounds like it should be "tuning-table", and shouldn't it also
have a prefix?

> +			node = of_find_compatible_node(NULL, NULL,
> +						"hisilicon,pctrl");

No need to use two lines here.

> +		ret = of_property_read_u32_array(np,
> +				"clken-reg", data, 2);

Or here, same with the other of_property_read_u32_array() calls.

> +MODULE_DESCRIPTION("K3 Specific DW-MSHC Driver Extension");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:dwmmc-k3");

Can you add a MODULE_AUTHOR too?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
