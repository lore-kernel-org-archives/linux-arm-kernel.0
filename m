From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 Oct 2012 10:14:05 +0200
Subject: [PATCH] pinctrl/nomadik: use irq_create_mapping()
In-Reply-To: <50817E43.8000804@wwwdotorg.org>
References: <1350659375-7335-1-git-send-email-linus.walleij@stericsson.com>
 <50817E43.8000804@wwwdotorg.org>
Message-ID: <CACRpkdbcTT_Mfa67Vw_6Y3RvqOE3CMA7kNXLG5oja0uTNn1FoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2012 at 6:22 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 10/19/2012 09:09 AM, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>
>> @@ -931,7 +931,7 @@ static void __nmk_gpio_irq_handler(unsigned int irq, struct irq_desc *desc,
>>       while (status) {
>>               int bit = __ffs(status);
>>
>> -             generic_handle_irq(irq_find_mapping(nmk_chip->domain, bit));
>> +             generic_handle_irq(irq_create_mapping(nmk_chip->domain, bit));
>
> Surely this one can remain as irq_find_mapping() since isn't
> nmk_gpio_to_irq() guaranteed to have been called first for this GPIO/IRQ?

It's an IRQ handler so it should be robust to spurious IRQs due to
transient hardware states etc I believe.

So if there is a transient IRQ before gpio_to_irq() is called -> boom.

Yours,
Linus Walleij
