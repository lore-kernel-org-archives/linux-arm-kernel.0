From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 11 Dec 2012 11:56:50 +0100
Subject: [PATCH] ARM: shmobile: r8a7779: Fix GPIO input reg addresses
In-Reply-To: <1355219295-4279-1-git-send-email-phil.edworthy@renesas.com>
References: <1355219295-4279-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <16942826.W5hEBZUpzF@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Phil,

Thank you for the patch.

Your SoB line is missing, have you forgotten to commit with -s ?

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Tuesday 11 December 2012 09:48:15 Phil Edworthy wrote:
> The INDTx register addresses were wrong.
> ---
>  arch/arm/mach-shmobile/pfc-r8a7779.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/pfc-r8a7779.c
> b/arch/arm/mach-shmobile/pfc-r8a7779.c index 15f6a48..717e058 100644
> --- a/arch/arm/mach-shmobile/pfc-r8a7779.c
> +++ b/arch/arm/mach-shmobile/pfc-r8a7779.c
> @@ -2585,13 +2585,13 @@ static struct pinmux_cfg_reg pinmux_config_regs[] =
> { };
> 
>  static struct pinmux_data_reg pinmux_data_regs[] = {
> -	{ PINMUX_DATA_REG("INDT0", 0xffc40008, 32) { GP_INDT(0) } },
> -	{ PINMUX_DATA_REG("INDT1", 0xffc41008, 32) { GP_INDT(1) } },
> -	{ PINMUX_DATA_REG("INDT2", 0xffc42008, 32) { GP_INDT(2) } },
> -	{ PINMUX_DATA_REG("INDT3", 0xffc43008, 32) { GP_INDT(3) } },
> -	{ PINMUX_DATA_REG("INDT4", 0xffc44008, 32) { GP_INDT(4) } },
> -	{ PINMUX_DATA_REG("INDT5", 0xffc45008, 32) { GP_INDT(5) } },
> -	{ PINMUX_DATA_REG("INDT6", 0xffc46008, 32) {
> +	{ PINMUX_DATA_REG("INDT0", 0xffc4000c, 32) { GP_INDT(0) } },
> +	{ PINMUX_DATA_REG("INDT1", 0xffc4100c, 32) { GP_INDT(1) } },
> +	{ PINMUX_DATA_REG("INDT2", 0xffc4200c, 32) { GP_INDT(2) } },
> +	{ PINMUX_DATA_REG("INDT3", 0xffc4300c, 32) { GP_INDT(3) } },
> +	{ PINMUX_DATA_REG("INDT4", 0xffc4400c, 32) { GP_INDT(4) } },
> +	{ PINMUX_DATA_REG("INDT5", 0xffc4500c, 32) { GP_INDT(5) } },
> +	{ PINMUX_DATA_REG("INDT6", 0xffc4600c, 32) {
>  		0, 0, 0, 0, 0, 0, 0, 0,	0, 0, 0, 0, 0, 0, 0, 0,
>  		0, 0, 0, 0, 0, 0, 0, GP_6_8_DATA,
>  		GP_6_7_DATA, GP_6_6_DATA, GP_6_5_DATA, GP_6_4_DATA,
-- 
Regards,

Laurent Pinchart
