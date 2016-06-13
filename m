From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Jun 2016 11:24:02 +0200
Subject: [PATCH 3/3] i.MX: system.c: Replace magic numbers
In-Reply-To: <1465797329-22537-3-git-send-email-andrew.smirnov@gmail.com>
References: <1465797329-22537-1-git-send-email-andrew.smirnov@gmail.com>
 <1465797329-22537-3-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <7839599.pSVM3KJL9Z@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, June 12, 2016 10:55:29 PM CEST Andrey Smirnov wrote:
> @@ -61,6 +61,13 @@
>  #define L2X0_LINE_TAG                  0xF30
>  #define L2X0_DEBUG_CTRL                        0xF40
>  #define L310_PREFETCH_CTRL             0xF60
> +#define   L310_DOUBLE_LINEFILL_EN                      BIT(30)
> +#define   L310_INSTRUCTION_PREFETCH_EN                 BIT(29)
> +#define   L310_DATA_PREFETCH_EN                                BIT(28)
> +#define   L310_DOUBLE_LINEFILL_ON_WRAP_READ_DIS                BIT(27)
> +#define   L310_PREFETCH_DROP_EN                                BIT(24)
> +#define   L310_INCR_DOUBLE_LINEFILL_EN                 BIT(23)
> +#define   L310_ESCLUSIVE_SEQUENCE_EN                   BIT(21)
>  #define L310_POWER_CTRL                        0xF80
>  #define   L310_DYNAMIC_CLK_GATING_EN   (1 << 1)
>  #define   L310_STNDBY_MODE_EN          (1 << 0)
> diff --git a/arch/arm/mach-imx/system.c b/arch/arm/mach-imx/system.c
> 


Most of these macros seem to all exist further down in the file already
under slightly differnet names, e.g.

#define L310_PREFETCH_CTRL_DBL_LINEFILL_INCR   BIT(23)

	Arnd
