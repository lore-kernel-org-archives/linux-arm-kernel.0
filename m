From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 20 Nov 2018 09:48:15 +0100
Subject: [RFC PATCH v2 05/14] irqchip/sun4i: add support for suniv
 interrupt controller
In-Reply-To: <d693414b1693a9018956bcc589a9048e88fbc8f6.1542546735.git.mesihkilinc@gmail.com>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
 <d693414b1693a9018956bcc589a9048e88fbc8f6.1542546735.git.mesihkilinc@gmail.com>
Message-ID: <20181120084815.rvh63cvvhxj6sbs2@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Nov 18, 2018 at 05:17:04PM +0300, Mesih Kilinc wrote:
> The new F-series SoCs (suniv) from Allwinner use an stripped version of
> the interrupt controller in A10/A13.
> 
> Add support for it in irq-sun4i driver.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  drivers/irqchip/irq-sun4i.c | 47 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 42 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-sun4i.c b/drivers/irqchip/irq-sun4i.c
> index e3e5b91..2abf662 100644
> --- a/drivers/irqchip/irq-sun4i.c
> +++ b/drivers/irqchip/irq-sun4i.c
> @@ -23,13 +23,26 @@
>  
>  #include <asm/exception.h>
>  
> +enum sun4i_irq_type {
> +	sun4i_ic,
> +	suniv_ic
> +};
> +
> +static enum sun4i_irq_type sun4i_irq_type;

You don't really need that type. It's completely redundant with the
compatible.

> +static int sun4i_irq_enable_reg_offset;
> +static int sun4i_irq_mask_reg_offset;

Ideally, this should be a structure so that we can easily extend it
without adding more and more global variables. And the type shouldn't
be signed.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181120/f43113d5/attachment-0001.sig>
