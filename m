From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 30 Sep 2015 14:54:12 +0100
Subject: [RFC PATCH] nvmem: rockchip_efuse_regmap_config can be static
In-Reply-To: <20150930134606.GA19541@lkp-nex05>
References: <201509302107.qXqgxYhn%fengguang.wu@intel.com>
 <20150930134606.GA19541@lkp-nex05>
Message-ID: <560BE984.8010101@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wow.. so fast :-)

Patch looks good to me.

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

On 30/09/15 14:46, kbuild test robot wrote:
>
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
> ---
>   rockchip-efuse.c |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efuse.c
> index 7887070..f552134 100644
> --- a/drivers/nvmem/rockchip-efuse.c
> +++ b/drivers/nvmem/rockchip-efuse.c
> @@ -101,7 +101,7 @@ static struct regmap_bus rockchip_efuse_bus = {
>   	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
>   };
>
> -struct regmap_config rockchip_efuse_regmap_config = {
> +static struct regmap_config rockchip_efuse_regmap_config = {
>   	.reg_bits = 32,
>   	.reg_stride = 1,
>   	.val_bits = 8,
> @@ -119,7 +119,7 @@ static const struct of_device_id rockchip_efuse_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, rockchip_efuse_match);
>
> -int rockchip_efuse_probe(struct platform_device *pdev)
> +static int rockchip_efuse_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct resource *res;
> @@ -165,7 +165,7 @@ int rockchip_efuse_probe(struct platform_device *pdev)
>   	return 0;
>   }
>
> -int rockchip_efuse_remove(struct platform_device *pdev)
> +static int rockchip_efuse_remove(struct platform_device *pdev)
>   {
>   	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
>
>
