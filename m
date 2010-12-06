From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 06 Dec 2010 14:39:05 +0300
Subject: [PATCH 22/54] ARM: iop33x: irq_data conversion.
In-Reply-To: <20101130133650.GW15575@mail.wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
	<20101130133650.GW15575@mail.wantstofly.org>
Message-ID: <4CFCCB59.80701@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30-11-2010 16:36, Lennert Buytenhek wrote:

> Signed-off-by: Lennert Buytenhek<buytenh@secretlab.ca>
[...]

> diff --git a/arch/arm/mach-iop33x/irq.c b/arch/arm/mach-iop33x/irq.c
> index abb4ea2..0ff2f74 100644
> --- a/arch/arm/mach-iop33x/irq.c
> +++ b/arch/arm/mach-iop33x/irq.c
> @@ -53,45 +53,45 @@ static void intsize_write(u32 val)
[...]
>   static void
> -iop33x_irq_unmask2(unsigned int irq)
> +iop33x_irq_unmask2(struct irq_data *d)
>   {
> -	iop33x_mask1 |= (1 << (irq - 32));
> +	iop33x_mask1 |= (1 << (d->irq - 32));

    Probably could have dropped useless parens, while at it...

WBR, Sergei
