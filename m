From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 23 May 2014 10:51:50 +0900 (JST)
Subject: [PATCH v2 1/2] irqchip: add Broadcom Set Top Box Level-2 interrupt
 controller
In-Reply-To: <1400776606-22427-2-git-send-email-f.fainelli@gmail.com>
References: <1400776606-22427-1-git-send-email-f.fainelli@gmail.com>
 <1400776606-22427-2-git-send-email-f.fainelli@gmail.com>
Message-ID: <alpine.DEB.2.02.1405231047050.9995@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 May 2014, Florian Fainelli wrote:
> +static void brcmstb_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
> +{
> +	struct brcmstb_l2_intc_data *b = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_get_chip(irq);

irq_desc_get_chip() is what you want here. irq_get_chip() is doing a
full lookop of desc, which is silly as you have desc already.

Thanks,

	tglx
