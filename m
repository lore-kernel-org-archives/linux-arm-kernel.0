From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 8 Jul 2011 09:23:59 +0200
Subject: [PATCH v6 2/4] ARM: mxs: add new a pad control
In-Reply-To: <1310102885-4102-3-git-send-email-b32955@freescale.com>
References: <1310102885-4102-1-git-send-email-b32955@freescale.com>
	<1310102885-4102-3-git-send-email-b32955@freescale.com>
Message-ID: <20110708072359.GO29624@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 01:28:03PM +0800, Huang Shijie wrote:
> add a new pad control which is used in some rare cases,
> such as gpmi-nand device.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  arch/arm/mach-mxs/include/mach/iomux.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/include/mach/iomux.h b/arch/arm/mach-mxs/include/mach/iomux.h
> index 7abdf58..1f31762 100644
> --- a/arch/arm/mach-mxs/include/mach/iomux.h
> +++ b/arch/arm/mach-mxs/include/mach/iomux.h
> @@ -94,6 +94,9 @@ typedef u32 iomux_cfg_t;
>  /* generic pad control used in most cases */
>  #define MXS_PAD_CTRL	(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL)
>  
> +/* special pad control used in rare cases */
I'd not talk about "rare cases" in the comment. It applies to most pads,
that they are used rarely (at most once per machine :-)
> +#define MXS_PAD_CTRL_12MA	(MXS_PAD_12MA | MXS_PAD_3V3 | MXS_PAD_NOPULL)
But other than that I fully support this definition.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
