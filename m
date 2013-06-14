From: ddaney.cavm@gmail.com (David Daney)
Date: Fri, 14 Jun 2013 10:20:47 -0700
Subject: [PATCH 6/7] MIPS: octeon: use irq_get_trigger_type() to get IRQ
 flags
In-Reply-To: <1371228049-27080-7-git-send-email-javier.martinez@collabora.co.uk>
References: <1371228049-27080-1-git-send-email-javier.martinez@collabora.co.uk>
 <1371228049-27080-7-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <51BB50EF.1050207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2013 09:40 AM, Javier Martinez Canillas wrote:
> Use irq_get_trigger_type() to get the IRQ trigger type flags
> instead calling irqd_get_trigger_type(irq_desc_get_irq_data(irq))
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Acked-by: David Daney <david.daney@cavium.com>

> ---
>   arch/mips/cavium-octeon/octeon-irq.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
> index a22f06a..7181def 100644
> --- a/arch/mips/cavium-octeon/octeon-irq.c
> +++ b/arch/mips/cavium-octeon/octeon-irq.c
> @@ -607,7 +607,7 @@ static void octeon_irq_ciu_gpio_ack(struct irq_data *data)
>
>   static void octeon_irq_handle_gpio(unsigned int irq, struct irq_desc *desc)
>   {
> -	if (irqd_get_trigger_type(irq_desc_get_irq_data(desc)) & IRQ_TYPE_EDGE_BOTH)
> +	if (irq_get_trigger_type(irq) & IRQ_TYPE_EDGE_BOTH)
>   		handle_edge_irq(irq, desc);
>   	else
>   		handle_level_irq(irq, desc);
>
