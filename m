From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 10 Sep 2018 16:30:54 +0800
Subject: [PATCH RESEND] drivers: soc: Allow building the sunxi driver
 without ARCH_SUNXI
In-Reply-To: <20180909190439.20425-1-contact@paulk.fr>
References: <20180909190439.20425-1-contact@paulk.fr>
Message-ID: <CAGb2v66=O6E43xKRkSDHm_Un_CEd2NQnNtyAH+C98i7Zyj7zdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Mon, Sep 10, 2018 at 3:04 AM Paul Kocialkowski <contact@paulk.fr> wrote:
>
> This makes it possible to build the sunxi SRAM driver without building
> for the sunxi architecture. This allows selecting the driver when
> building the kernel in testing environments.
>
> In particular, this is necessary for testing of the Cedrus driver, that
> selects the sunxi SRAM driver.
>
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  drivers/soc/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 113e884697fd..446166ba0bec 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -18,7 +18,7 @@ obj-y                         += qcom/
>  obj-y                          += renesas/
>  obj-$(CONFIG_ARCH_ROCKCHIP)    += rockchip/
>  obj-$(CONFIG_SOC_SAMSUNG)      += samsung/
> -obj-$(CONFIG_ARCH_SUNXI)       += sunxi/
> +obj-y                          += sunxi/
>  obj-$(CONFIG_ARCH_TEGRA)       += tegra/
>  obj-$(CONFIG_SOC_TI)           += ti/
>  obj-$(CONFIG_ARCH_U8500)       += ux500/
> --
> 2.18.0
>

Do you want us to merge this on an immutable tag for you to pull?

ChenYu
