From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Wed, 12 Aug 2015 09:27:40 -0700
Subject: [PATCH] pinctrl-zynq.c: Fix typos in smc0_nand_grp and
 smc0_nor_grp
In-Reply-To: <1439389332-9373-1-git-send-email-mike.looijmans@topic.nl>
References: <1439389332-9373-1-git-send-email-mike.looijmans@topic.nl>
Message-ID: <CAAtXAHdbHoqMQP0wHpHiUbD6d6W8WcDaB=5VR2D5Nh29Seue9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Moritz Fischer <moritz.fischer@ettus.com>

On Wed, Aug 12, 2015 at 7:22 AM, Mike Looijmans <mike.looijmans@topic.nl> wrote:
> Group names should be smc0_nand_grp and smc0_nor_grp, otherwise you'll
> get errors like this if you try to pinmux them via the devicetree:
> zynq-pinctrl 700.pinctrl: invalid group "smc0_nand_grp" for function "smc0_nand"
>
> Probably a typo while creating these tables.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  drivers/pinctrl/pinctrl-zynq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
> index 7ce23b6..5aafea8 100644
> --- a/drivers/pinctrl/pinctrl-zynq.c
> +++ b/drivers/pinctrl/pinctrl-zynq.c
> @@ -706,10 +706,10 @@ static const char * const sdio1_wp_groups[] = {"gpio0_0_grp",
>                 "gpio0_39_grp", "gpio0_41_grp", "gpio0_43_grp",
>                 "gpio0_45_grp", "gpio0_47_grp", "gpio0_49_grp",
>                 "gpio0_51_grp", "gpio0_53_grp", "sdio1_emio_wp_grp"};
> -static const char * const smc0_nor_groups[] = {"smc0_nor"};
> +static const char * const smc0_nor_groups[] = {"smc0_nor_grp"};
>  static const char * const smc0_nor_cs1_groups[] = {"smc0_nor_cs1_grp"};
>  static const char * const smc0_nor_addr25_groups[] = {"smc0_nor_addr25_grp"};
> -static const char * const smc0_nand_groups[] = {"smc0_nand"};
> +static const char * const smc0_nand_groups[] = {"smc0_nand_grp"};
>  static const char * const can0_groups[] = {"can0_0_grp", "can0_1_grp",
>                 "can0_2_grp", "can0_3_grp", "can0_4_grp", "can0_5_grp",
>                 "can0_6_grp", "can0_7_grp", "can0_8_grp", "can0_9_grp",
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
