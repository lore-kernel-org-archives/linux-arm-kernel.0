From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 06 Dec 2010 14:34:13 +0300
Subject: [PATCH 12/54] ARM: davinci: irq_data conversion.
In-Reply-To: <20101130133636.GM15575@mail.wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
	<20101130133636.GM15575@mail.wantstofly.org>
Message-ID: <4CFCCA35.4030805@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 30-11-2010 16:36, Lennert Buytenhek wrote:

> Signed-off-by: Lennert Buytenhek<buytenh@secretlab.ca>
[...]

> diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
> index 784ddf3..f5f417e 100644
> --- a/arch/arm/mach-davinci/irq.c
> +++ b/arch/arm/mach-davinci/irq.c
> @@ -53,14 +53,14 @@ static inline void davinci_irq_writel(unsigned long value, int offset)
[...]
> @@ -91,23 +91,23 @@ static void davinci_unmask_irq(unsigned int irq)
[...]
>   static struct irq_chip davinci_irq_chip_0 = {
> -	.name	= "AINTC",
> -	.ack	= davinci_ack_irq,
> -	.mask	= davinci_mask_irq,
> -	.unmask = davinci_unmask_irq,
> +	.name		= "AINTC",
> +	.irq_ack	= davinci_ack_irq,
> +	.irq_mask	= davinci_mask_irq,
> +	.irq_unmask = davinci_unmask_irq,

    Er, you forgot to align it?

WBR, Sergei
