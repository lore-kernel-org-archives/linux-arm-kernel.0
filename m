From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Jun 2012 11:12:05 +0200
Subject: [PATCH 08/14] mfd: Add IRQ domain support for the AB8500
In-Reply-To: <20120618102003.GB12029@n2100.arm.linux.org.uk>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-9-git-send-email-lee.jones@linaro.org>
 <20120614183231.GA30185@sirena.org.uk>
 <4FDEEEBD.5070108@linaro.org>
 <20120618102003.GB12029@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdZDVDZYKsT9Lxg3_ef6YKgmcWFa7-o+2PAmYpy47JDysw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 12:20 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jun 18, 2012 at 10:02:53AM +0100, Lee Jones wrote:
>> @@ -361,7 +362,7 @@ static void ab8500_irq_sync_unlock(struct irq_data *data)
>> ?static void ab8500_irq_mask(struct irq_data *data)
>> ?{
>> ? ? ? struct ab8500 *ab8500 = irq_data_get_irq_chip_data(data);
>> - ? ? int offset = data->irq - ab8500->irq_base;
>> + ? ? int offset = data->irq;
>
> Are you sure this is right? ?I thought irq_data->irq was the Linux IRQ
> number, irq_data->hwirq was the interrupt number inside the domain.

Agree, this need to be fixed and respin...

Yours,
Linus Walleij
