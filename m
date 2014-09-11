From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Sep 2014 18:24:11 +0200
Subject: [PATCH 1/7] irqchip: atmel-aic5: Add sama5d4 support
In-Reply-To: <1410450852-1834-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1410450852-1834-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1410450852-1834-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140911182411.0366ad98@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Alexandre Belloni,

On Thu, 11 Sep 2014 17:54:06 +0200, Alexandre Belloni wrote:
> Add sama5d4 support to irq-atmel-aic5.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> Cc: Jason Cooper <jason@lakedaemon.net>
>  drivers/irqchip/irq-atmel-aic5.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
> index dc7d98607a89..a11aae8fb006 100644
> --- a/drivers/irqchip/irq-atmel-aic5.c
> +++ b/drivers/irqchip/irq-atmel-aic5.c
> @@ -295,6 +295,7 @@ static void __init sama5d3_aic_irq_fixup(struct device_node *root)
>  
>  static const struct of_device_id __initdata aic5_irq_fixups[] = {
>  	{ .compatible = "atmel,sama5d3", .data = sama5d3_aic_irq_fixup },
> +	{ .compatible = "atmel,sama5d4", .data = sama5d3_aic_irq_fixup },
>  	{ /* sentinel */ },
>  };

Sorry for the nitpick, but this seems to lack an updated to the DT
binding documentation, to add the new compatible string.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
