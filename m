From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 05 Feb 2014 09:47:04 +0900
Subject: [PATCH 11/18] extcon: max14577: Add max14577 prefix to muic_irqs
In-Reply-To: <1390911522-28209-12-git-send-email-k.kozlowski@samsung.com>
References: <1390911522-28209-1-git-send-email-k.kozlowski@samsung.com>
 <1390911522-28209-12-git-send-email-k.kozlowski@samsung.com>
Message-ID: <52F18A08.6070409@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

Following patch has conflict on extcon-next branch(Linus 3.14-rc1)
when apply patchset by using git am.

[PATCH 11/18] extcon: max14577: Add max14577 prefix to muic_irqs
[PATCH 12/18] extcon: max14577: Choose muic_irqs according to device type
[PATCH 14/18] extcon: max14577: Add support for max77836

The base commit of this patchset isn't mainline. You need to rebase this patchset 
on extcon-next branch and please resend this patchset.

Thanks,
Chanwoo Choi

On 01/28/2014 09:18 PM, Krzysztof Kozlowski wrote:
> Add max14577 prefix to muic_irqs array. This prepares for max77836
> support in this extcon driver.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/extcon/extcon-max14577.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-max14577.c b/drivers/extcon/extcon-max14577.c
> index fd48b4909470..fb343f4042d2 100644
> --- a/drivers/extcon/extcon-max14577.c
> +++ b/drivers/extcon/extcon-max14577.c
> @@ -85,7 +85,7 @@ struct max14577_muic_irq {
>  	unsigned int virq;
>  };
>  
> -static struct max14577_muic_irq muic_irqs[] = {
> +static struct max14577_muic_irq max14577_muic_irqs[] = {
>  	{ MAXIM_IRQ_INT1_ADC,		"muic-ADC" },
>  	{ MAXIM_IRQ_INT1_ADCLOW,	"muic-ADCLOW" },
>  	{ MAXIM_IRQ_INT1_ADCERR,	"muic-ADCError" },
> @@ -541,9 +541,9 @@ static irqreturn_t max14577_muic_irq_handler(int irq, void *data)
>  	 * However we only need to know whether it was ADC, charger
>  	 * or both interrupts so decode IRQ and turn on proper flags.
>  	 */
> -	for (i = 0; i < ARRAY_SIZE(muic_irqs); i++)
> -		if (irq == muic_irqs[i].virq)
> -			irq_type = muic_irqs[i].irq;
> +	for (i = 0; i < ARRAY_SIZE(max14577_muic_irqs); i++)
> +		if (irq == max14577_muic_irqs[i].virq)
> +			irq_type = max14577_muic_irqs[i].irq;
>  
>  	switch (irq_type) {
>  	case MAXIM_IRQ_INT1_ADC:
> @@ -647,8 +647,8 @@ static int max14577_muic_probe(struct platform_device *pdev)
>  	INIT_WORK(&info->irq_work, max14577_muic_irq_work);
>  
>  	/* Support irq domain for max14577 MUIC device */
> -	for (i = 0; i < ARRAY_SIZE(muic_irqs); i++) {
> -		struct max14577_muic_irq *muic_irq = &muic_irqs[i];
> +	for (i = 0; i < ARRAY_SIZE(max14577_muic_irqs); i++) {
> +		struct max14577_muic_irq *muic_irq = &max14577_muic_irqs[i];
>  		unsigned int virq = 0;
>  
>  		virq = regmap_irq_get_virq(maxim_core->irq_data_muic,
> 
