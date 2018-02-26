From: ludovic.barre@st.com (Ludovic BARRE)
Date: Mon, 26 Feb 2018 16:25:37 +0100
Subject: [PATCH v2 2/2] pinctrl: stm32: Optimizes and enhances stm32gpio
 irqchip
In-Reply-To: <c648235f538b030e7f349e286661fd00894d5316.1519374248.git.radoslaw.pietrzyk@gmail.com>
References: <1519221027-4028-1-git-send-email-radoslaw.pietrzyk@gmail.com>
 <cover.1519374248.git.radoslaw.pietrzyk@gmail.com>
 <c648235f538b030e7f349e286661fd00894d5316.1519374248.git.radoslaw.pietrzyk@gmail.com>
Message-ID: <83f7cbec-05f6-a937-a848-bd533bb1001a@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Radoslaw

Reviewed-by: Ludovic Barre <ludovic.barre@st.com>
Tested-by: Ludovic Barre <ludovic.barre@st.com>

BR
Ludo

On 02/23/2018 09:31 AM, Radoslaw Pietrzyk wrote:
> - removes unneeded irq_chip.irq_eoi callback
> - adds irq_chip.irq_set_wake callback for possible
> in the future GPIO wakeup
> - adds irq_chip.irq_ack callback
> 
> Signed-off-by: Radoslaw Pietrzyk <radoslaw.pietrzyk@gmail.com>
> ---
>   drivers/pinctrl/stm32/pinctrl-stm32.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
> index 617df16..6cbcff4 100644
> --- a/drivers/pinctrl/stm32/pinctrl-stm32.c
> +++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
> @@ -268,10 +268,11 @@ static void stm32_gpio_irq_release_resources(struct irq_data *irq_data)
>   
>   static struct irq_chip stm32_gpio_irq_chip = {
>   	.name           = "stm32gpio",
> -	.irq_eoi	= irq_chip_eoi_parent,
> +	.irq_ack       = irq_chip_ack_parent,
>   	.irq_mask       = irq_chip_mask_parent,
>   	.irq_unmask     = irq_chip_unmask_parent,
>   	.irq_set_type   = irq_chip_set_type_parent,
> +	.irq_set_wake   = irq_chip_set_wake_parent,
>   	.irq_request_resources = stm32_gpio_irq_request_resources,
>   	.irq_release_resources = stm32_gpio_irq_release_resources,
>   };
> 
