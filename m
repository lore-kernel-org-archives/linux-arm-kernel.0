From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 19 Feb 2016 00:19:18 +0100
Subject: [PATCH v2 1/5] MIPS: jz4740: remove broken irq_to_gpio() call
In-Reply-To: <20160216160609.GA15268@linux-mips.org>
References: <455637086-2794174-1-git-send-email-arnd@arndb.de>
 <1455637261-2920972-1-git-send-email-arnd@arndb.de>
 <20160216160609.GA15268@linux-mips.org>
Message-ID: <CACRpkda=TFuUWzV_pLKoVhCZp1zWbEjoGmCey_w87bsuQZZ=jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 5:06 PM, Ralf Baechle <ralf@linux-mips.org> wrote:

>> -#define IRQ_TO_BIT(irq) BIT(irq_to_gpio(irq) & 0x1f)
>> +#define IRQ_TO_BIT(irq) BIT((irq - JZ4740_IRQ_GPIO(0)) & 0x1f)
>>
>>  static void jz_gpio_check_trigger_both(struct jz_gpio_chip *chip, unsigned int irq)
>>  {
>
> I've already committed an identical fix locally.
>
>   Ralf

I took that fix out of linux-next and applied to the GPIO tree so I can apply
the rest of the patches without build problems. If you keep it
around without changing it, git should cope I guess.

Yours,
Linus Walleij
