From: frank.wang@rock-chips.com (Frank Wang)
Date: Mon, 5 Jun 2017 11:51:00 +0800
Subject: [PATCH] nvmem: rockchip-efuse: add support for rk322x-efuse
In-Reply-To: <1494557060-105230-1-git-send-email-finley.xiao@rock-chips.com>
References: <1494557060-105230-1-git-send-email-finley.xiao@rock-chips.com>
Message-ID: <ea1652a0-d249-6e33-a3ba-828a1ebdb860@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Finley,

On 2017/5/12 10:44, Finley Xiao wrote:
> This adds the necessary data for handling eFuse on the rk322x.
>
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> ---
>   Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt | 1 +
>   drivers/nvmem/rockchip-efuse.c                             | 4 ++++
>   2 files changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt
> index 94aeeea..194926f 100644
> --- a/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt
> +++ b/Documentation/devicetree/bindings/nvmem/rockchip-efuse.txt
> @@ -4,6 +4,7 @@ Required properties:
>   - compatible: Should be one of the following.
>     - "rockchip,rk3066a-efuse" - for RK3066a SoCs.
>     - "rockchip,rk3188-efuse" - for RK3188 SoCs.
> +  - "rockchip,rk322x-efuse" - for RK322x SoCs.

As the comments from Heiko in other patches, compatibles should not 
contain wildcards, so could you please make this
     "rockchip,rk3228-efuse"
instead?

>     - "rockchip,rk3288-efuse" - for RK3288 SoCs.
>     - "rockchip,rk3399-efuse" - for RK3399 SoCs.
>   - reg: Should contain the registers location and exact eFuse size
> diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efuse.c
> index 423907b..a0d4ede 100644
> --- a/drivers/nvmem/rockchip-efuse.c
> +++ b/drivers/nvmem/rockchip-efuse.c
> @@ -170,6 +170,10 @@ static const struct of_device_id rockchip_efuse_match[] = {
>   		.data = (void *)&rockchip_rk3288_efuse_read,
>   	},
>   	{
> +		.compatible = "rockchip,rk322x-efuse",
> +		.data = (void *)&rockchip_rk3288_efuse_read,
> +	},

The same as above.


BR.
Frank

> +	{
>   		.compatible = "rockchip,rk3288-efuse",
>   		.data = (void *)&rockchip_rk3288_efuse_read,
>   	},
