From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 9 Mar 2018 08:16:03 +0000
Subject: [PATCH v4 0/4] Set name of regmap_config
In-Reply-To: <20180309015146.8297-1-jeffy.chen@rock-chips.com>
References: <20180309015146.8297-1-jeffy.chen@rock-chips.com>
Message-ID: <20180309081603.4u5pgwwsfxernodm@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 09 Mar 2018, Jeffy Chen wrote:

> 
> After 9b947a13e7f6 ("regmap: use debugfs even when no device"), we are
> allowing regmap to create debugfs without a valid device. Some of them
> would end up using "dummy*" as debugfs name.
> 
> This series try to set names in some regmap_config to avoid that.
> 
> 
> Changes in v4:
> Not to use rtc dev to init regmap, the gpbr is not directly related to
> the rtc.
> 
> Changes in v3:
> Modify commit message.
> 
> Jeffy Chen (4):
>   mfd: syscon: Set name of regmap_config
>   rtc: at91sam9: Set name of regmap_config
>   clk: lpc32xx: Set name of regmap_config
>   ARM: rockchip: Set name of regmap_config
> 
>  arch/arm/mach-rockchip/platsmp.c | 1 +
>  drivers/clk/nxp/clk-lpc32xx.c    | 1 +
>  drivers/mfd/syscon.c             | 1 +

It's difficult to review, since we cannot see what's happening with
the rest of the patch set.  Would you mind re-sending the whole set to
all parties please?

>  drivers/rtc/rtc-at91sam9.c       | 1 +
>  4 files changed, 4 insertions(+)
> 

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
