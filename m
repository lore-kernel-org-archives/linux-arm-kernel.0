From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 1 Jun 2011 09:30:58 +0200
Subject: [PATCH 1/2] sdio: add function to enable and disable
	sdio_single_irq optimization
In-Reply-To: <1306874008-28867-2-git-send-email-per.forlin@linaro.org>
References: <1306874008-28867-1-git-send-email-per.forlin@linaro.org>
	<1306874008-28867-2-git-send-email-per.forlin@linaro.org>
Message-ID: <BANLkTinUEq_tvCtXWjg3t6L589y80nPPog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/31 Per Forlin <per.forlin@linaro.org>:

> +/**
> + * ? ? sdio_single_irq_enable - enable or disable SDIO single IRQ function
> + * ? ? @card: card to enable SDIO single irq
> + * ? ? @value: true to enable SDIO single irq function, false to disable
> + *
> + * ? ? If there is only 1 function interrupt registered and SDIO single IRQ
> + * ? ? is enable, the irq handler is called directly without reading
> + * ? ? the CCCR registers
> + */
> +void sdio_single_irq_enable(struct mmc_card *card, bool value)
> +{
> + ? ? ? card->sdio_single_irq_en = value;
> +}
> +EXPORT_SYMBOL_GPL(sdio_single_irq_enable);

Can we use a quirk for implementing this for the specific problematic
card instead?

Daniel, do you have the vendor and device ID for the problematic
Libertas card you're working on so this can be quirked explicitly
in drivers/mmc/core/quirks.c?

Yours,
Linus Walleij
