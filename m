From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Jun 2012 11:20:03 +0100
Subject: [PATCH 08/14] mfd: Add IRQ domain support for the AB8500
In-Reply-To: <4FDEEEBD.5070108@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-9-git-send-email-lee.jones@linaro.org>
 <20120614183231.GA30185@sirena.org.uk> <4FDEEEBD.5070108@linaro.org>
Message-ID: <20120618102003.GB12029@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 10:02:53AM +0100, Lee Jones wrote:
> @@ -361,7 +362,7 @@ static void ab8500_irq_sync_unlock(struct irq_data *data)
>  static void ab8500_irq_mask(struct irq_data *data)
>  {
>  	struct ab8500 *ab8500 = irq_data_get_irq_chip_data(data);
> -	int offset = data->irq - ab8500->irq_base;
> +	int offset = data->irq;

Are you sure this is right?  I thought irq_data->irq was the Linux IRQ
number, irq_data->hwirq was the interrupt number inside the domain.
