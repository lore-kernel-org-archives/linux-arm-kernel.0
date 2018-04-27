From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 27 Apr 2018 18:42:27 +0900
Subject: [PATCH] reset: uniphier: fix USB clock line for LD20
In-Reply-To: <1523499370-17757-1-git-send-email-yamada.masahiro@socionext.com>
References: <1523499370-17757-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNAQKVD3aKTo_z=zkOdoL--RogoFm0bt-dCBsWFN8BEPpSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Philipp,

2018-04-12 11:16 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> For LD20, the bit 5 of the offset 0x200c turned out to be a USB3
> reset.  The hardware document says it is the GIO reset despite LD20
> has no GIO bus, confusingly.
>
> Also, fix confusing comments for PXs3.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Can you take a look at this, please?




>  drivers/reset/reset-uniphier.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/reset/reset-uniphier.c b/drivers/reset/reset-uniphier.c
> index 360e06b..ac18f2f 100644
> --- a/drivers/reset/reset-uniphier.c
> +++ b/drivers/reset/reset-uniphier.c
> @@ -110,7 +110,7 @@ static const struct uniphier_reset_data uniphier_ld20_sys_reset_data[] = {
>         UNIPHIER_RESETX(4, 0x200c, 2),          /* eMMC */
>         UNIPHIER_RESETX(6, 0x200c, 6),          /* Ether */
>         UNIPHIER_RESETX(8, 0x200c, 8),          /* STDMAC (HSC) */
> -       UNIPHIER_RESETX(12, 0x200c, 5),         /* GIO (PCIe, USB3) */
> +       UNIPHIER_RESETX(14, 0x200c, 5),         /* USB30 */
>         UNIPHIER_RESETX(16, 0x200c, 12),        /* USB30-PHY0 */
>         UNIPHIER_RESETX(17, 0x200c, 13),        /* USB30-PHY1 */
>         UNIPHIER_RESETX(18, 0x200c, 14),        /* USB30-PHY2 */
> @@ -127,8 +127,8 @@ static const struct uniphier_reset_data uniphier_pxs3_sys_reset_data[] = {
>         UNIPHIER_RESETX(6, 0x200c, 9),          /* Ether0 */
>         UNIPHIER_RESETX(7, 0x200c, 10),         /* Ether1 */
>         UNIPHIER_RESETX(8, 0x200c, 12),         /* STDMAC */
> -       UNIPHIER_RESETX(12, 0x200c, 4),         /* USB30 link (GIO0) */
> -       UNIPHIER_RESETX(13, 0x200c, 5),         /* USB31 link (GIO1) */
> +       UNIPHIER_RESETX(12, 0x200c, 4),         /* USB30 link */
> +       UNIPHIER_RESETX(13, 0x200c, 5),         /* USB31 link */
>         UNIPHIER_RESETX(16, 0x200c, 16),        /* USB30-PHY0 */
>         UNIPHIER_RESETX(17, 0x200c, 18),        /* USB30-PHY1 */
>         UNIPHIER_RESETX(18, 0x200c, 20),        /* USB30-PHY2 */
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
