From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 23 Feb 2018 16:16:39 +0100
Subject: [PATCH v3 1/7] pinctrl: sunxi: refactor irq related register
 function to have desc
In-Reply-To: <20180223122552.58049-2-icenowy@aosc.io>
References: <20180223122552.58049-1-icenowy@aosc.io>
 <20180223122552.58049-2-icenowy@aosc.io>
Message-ID: <20180223151639.wru7b67byksefxpk@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Feb 23, 2018 at 08:25:46PM +0800, Icenowy Zheng wrote:
> As the new H6 SoC has holes in the IRQ registers, refactor the IRQ
> related register function for getting the full pinctrl desc structure.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> New patch in v3.
> 
>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 18 ++++++++----------
>  drivers/pinctrl/sunxi/pinctrl-sunxi.h | 29 +++++++++++++++++++++--------
>  2 files changed, 29 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> index 341312d66512..31bd99f7df50 100644
> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
> @@ -835,7 +835,7 @@ static void sunxi_pinctrl_irq_release_resources(struct irq_data *d)
>  static int sunxi_pinctrl_irq_set_type(struct irq_data *d, unsigned int type)
>  {
>  	struct sunxi_pinctrl *pctl = irq_data_get_irq_chip_data(d);
> -	u32 reg = sunxi_irq_cfg_reg(d->hwirq, pctl->desc->irq_bank_base);
> +	u32 reg = sunxi_irq_cfg_reg(d->hwirq, pctl->desc);

That's better, but it makes more sense to have the desc as the first
argument.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180223/b4a6a953/attachment.sig>
