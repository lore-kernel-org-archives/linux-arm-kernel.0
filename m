From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 01 Dec 2010 08:33:25 +1300
Subject: [PATCH 15/54] ARM: ep93xx: irq_data conversion.
In-Reply-To: <20101130133639.GP15575@mail.wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
	<20101130133639.GP15575@mail.wantstofly.org>
Message-ID: <4CF55185.6010808@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/01/2010 02:36 AM, Lennert Buytenhek wrote:
> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
> ---
>  arch/arm/mach-ep93xx/gpio.c |   36 ++++++++++++++++++------------------
>  1 files changed, 18 insertions(+), 18 deletions(-)
> 

<snip>

> -static int ep93xx_gpio_irq_type(unsigned int irq, unsigned int type)
> +static int ep93xx_gpio_irq_type(struct irq_data *d, unsigned int type)
>  {
> -	struct irq_desc *desc = irq_desc + irq;
> -	const int gpio = irq_to_gpio(irq);
> +	struct irq_desc *desc = irq_desc + d->irq;

Is this still correct? I haven't followed much of the irq_data
discussion, but this post (https://patchwork.kernel.org/patch/230221/)
says that with sparse irq converting irq number to irq_desc is now a
radix tree lookup.

I get the impression from the above email that we should be avoiding
using irq_desc directly in these functions?

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
