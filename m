From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 20 May 2015 20:54:12 +0200
Subject: [RFC v1 15/25] genirq: Kill the first parameter 'irq' of
 irq_flow_handler_t
In-Reply-To: <1432116013-25902-16-git-send-email-jiang.liu@linux.intel.com>
 (Jiang Liu's message of "Wed, 20 May 2015 18:00:03 +0800")
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com>
 <1432116013-25902-16-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <87mw0zhygb.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jiang Liu <jiang.liu@linux.intel.com> writes:

> diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c b/arch/arm/mach-pxa/pcm990-baseboard.c
> index 2897da2a5df6..0d8331f8536e 100644
> --- a/arch/arm/mach-pxa/pcm990-baseboard.c
> +++ b/arch/arm/mach-pxa/pcm990-baseboard.c
> @@ -287,6 +287,7 @@ static struct irq_chip pcm990_irq_chip = {
>  static void pcm990_irq_handler(unsigned int irq, struct irq_desc *desc)
>  {
>  	unsigned long pending;
> +	unsigned int irq;
That doesn't look good, double irq definition.

Cheers.

-- 
Robert
