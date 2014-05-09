From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 9 May 2014 12:23:03 +0200
Subject: [PATCH v2] pinctrl/at91: Fix lockup when IRQ on PIOC and PIOD
 occurs
In-Reply-To: <CACRpkdayBjvOnSfaRmcNenSG=MW0W+UFjqUjGoQwqDNFLQ9zEQ@mail.gmail.com>
References: <1398289203-2407-1-git-send-email-alexanders83@web.de>
 <1398362139-25551-1-git-send-email-alexanders83@web.de>
 <CACRpkdayBjvOnSfaRmcNenSG=MW0W+UFjqUjGoQwqDNFLQ9zEQ@mail.gmail.com>
Message-ID: <536CAC87.9070007@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/04/2014 11:18, Linus Walleij :
> On Thu, Apr 24, 2014 at 7:55 PM, Alexander Stein <alexanders83@web.de> wrote:
> 
>> With commit 80cc3732 (pinctrl/at91: convert driver to use gpiolib irqchip)
>> gpiochip_set_chained_irqchip is called for PIOC, PIOD and PIOE. The
>> associated GPIO chip for the IRQ chip is overwritten each time, because
>> they share the same hard IRQ line.
>> Thus if an IRQ occurs on PIOC or PIOD, gpio_irq_handler will only check on
>> PIOE (the assigned GPIO chip) where no event occured. Thus the IRQ will
>> not be cleared, retriggering the ISR.
>> Fix that (like done before) by only set the PIOC GPIO chip to the IRQ chip
>> and walk the list in the irq handler.
>>
>> Signed-off-by: Alexander Stein <alexanders83@web.de>
>> ---
>> Changes in v2:
>> * Fix git SHA1 in commit message (used local one)
>> * Switch to the next gpio_chip when walking the list
> 
> This v2 patch applied for next.

Linus,

I do not see this patch in your "for-next" branch nor in linux-next. Did
I miss something?

Bye,
-- 
Nicolas Ferre
