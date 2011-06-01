From: per.forlin@linaro.org (Per Forlin)
Date: Wed, 1 Jun 2011 09:39:09 +0200
Subject: [PATCH 1/2] sdio: add function to enable and disable
	sdio_single_irq optimization
In-Reply-To: <BANLkTinUEq_tvCtXWjg3t6L589y80nPPog@mail.gmail.com>
References: <1306874008-28867-1-git-send-email-per.forlin@linaro.org>
	<1306874008-28867-2-git-send-email-per.forlin@linaro.org>
	<BANLkTinUEq_tvCtXWjg3t6L589y80nPPog@mail.gmail.com>
Message-ID: <BANLkTi=pa1hC_nm1HmWRLO+vw_set=py0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 June 2011 09:30, Linus Walleij <linus.walleij@linaro.org> wrote:
> 2011/5/31 Per Forlin <per.forlin@linaro.org>:
>
>> +/**
>> + * ? ? sdio_single_irq_enable - enable or disable SDIO single IRQ function
>> + * ? ? @card: card to enable SDIO single irq
>> + * ? ? @value: true to enable SDIO single irq function, false to disable
>> + *
>> + * ? ? If there is only 1 function interrupt registered and SDIO single IRQ
>> + * ? ? is enable, the irq handler is called directly without reading
>> + * ? ? the CCCR registers
>> + */
>> +void sdio_single_irq_enable(struct mmc_card *card, bool value)
>> +{
>> + ? ? ? card->sdio_single_irq_en = value;
>> +}
>> +EXPORT_SYMBOL_GPL(sdio_single_irq_enable);
>
> Can we use a quirk for implementing this for the specific problematic
> card instead?
>
Yes, quirks is the thing I should use.
I'll remove this function and replace it with a quirk. The default
state could then be sdio_single_irq enable and for all none supported
hardware (device ID) sdio_single_irq will be disable.

> Daniel, do you have the vendor and device ID for the problematic
> Libertas card you're working on so this can be quirked explicitly
> in drivers/mmc/core/quirks.c?
>
Even if Daniel fix this issue in libertas it is still good to have a
sdio_single_irq quirk in place for other SDIO devices with the same
hardware issue.

> Yours,
> Linus Walleij
>
Thanks,
Per
