From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 21 Sep 2018 15:43:16 +0200
Subject: [PATCH -next] pinctrl: sunxi: fix 'pctrl->functions' allocation
 in sunxi_pinctrl_build_state
In-Reply-To: <20180921015941.28468-1-yuehaibing@huawei.com>
References: <20180921015941.28468-1-yuehaibing@huawei.com>
Message-ID: <20180921134316.io4isy7fgewjkcrv@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2018 at 09:59:41AM +0800, YueHaibing wrote:
> fixes following Smatch static check warning:
> 
>  ./drivers/pinctrl/sunxi/pinctrl-sunxi.c:1112 sunxi_pinctrl_build_state()
>  warn: passing devm_ allocated variable to kfree. 'pctrl->functions'
> 
> As we will be calling krealloc() on pointer 'pctrl->functions', which means
> kfree() will be called in there, devm_kzalloc() shouldn't be used with
> the allocation in the first place.  Fix the warning by calling kcalloc()
> and managing the free procedure in error path on our own.
> 
> Fixes: 0e37f88d9ad8 ("ARM: sunxi: Add pinctrl driver for Allwinner SoCs")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180921/7d9255b0/attachment.sig>
