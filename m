From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 19 Jul 2018 17:13:39 +0900
Subject: [PATCH] reset: uniphier: add reset control support for SPI
In-Reply-To: <1531981133-25881-1-git-send-email-hayashibara.keiji@socionext.com>
References: <1531981133-25881-1-git-send-email-hayashibara.keiji@socionext.com>
Message-ID: <CAK7LNASajYVUUz0Ggvpco9HhZVwp0Yw_t82Lq6YKXgsN0wLDGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-07-19 15:18 GMT+09:00 Keiji Hayashibara <hayashibara.keiji@socionext.com>:
> From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>
> Add reset control for SPI controller on UniPhier SoCs.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---


Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


>  drivers/reset/reset-uniphier.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
> index e9030ff..5605745 100644
> --- a/drivers/reset/reset-uniphier.c
> +++ b/drivers/reset/reset-uniphier.c
> @@ -202,6 +202,12 @@ static const struct uniphier_reset_data uniphier_pro5_sd_reset_data[] = {
>  #define UNIPHIER_PERI_RESET_FI2C(id, ch)               \
>         UNIPHIER_RESETX((id), 0x114, 24 + (ch))
>
> +#define UNIPHIER_PERI_RESET_SCSSI(id)                  \
> +       UNIPHIER_RESETX((id), 0x110, 17)
> +
> +#define UNIPHIER_PERI_RESET_MCSSI(id)                  \
> +       UNIPHIER_RESETX((id), 0x114, 14)
> +
>  static const struct uniphier_reset_data uniphier_ld4_peri_reset_data[] = {
>         UNIPHIER_PERI_RESET_UART(0, 0),
>         UNIPHIER_PERI_RESET_UART(1, 1),
> @@ -212,6 +218,7 @@ static const struct uniphier_reset_data uniphier_ld4_peri_reset_data[] = {
>         UNIPHIER_PERI_RESET_I2C(6, 2),
>         UNIPHIER_PERI_RESET_I2C(7, 3),
>         UNIPHIER_PERI_RESET_I2C(8, 4),
> +       UNIPHIER_PERI_RESET_SCSSI(11),
>         UNIPHIER_RESET_END,
>  };
>
> @@ -227,6 +234,8 @@ static const struct uniphier_reset_data uniphier_pro4_peri_reset_data[] = {
>         UNIPHIER_PERI_RESET_FI2C(8, 4),
>         UNIPHIER_PERI_RESET_FI2C(9, 5),
>         UNIPHIER_PERI_RESET_FI2C(10, 6),
> +       UNIPHIER_PERI_RESET_SCSSI(11),
> +       UNIPHIER_PERI_RESET_MCSSI(12),
>         UNIPHIER_RESET_END,
>  };
>
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
