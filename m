From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 3 Jan 2010 16:07:04 +0800
Subject: [PATCH 2/7] [ARM] locomo: avoid the unnecessary cascade of
	keyboard IRQ
In-Reply-To: <20100102114324.GC2529@n2100.arm.linux.org.uk>
References: <1261977488-18271-1-git-send-email-eric.y.miao@gmail.com>
	<1261977488-18271-3-git-send-email-eric.y.miao@gmail.com>
	<20100102114324.GC2529@n2100.arm.linux.org.uk>
Message-ID: <f17812d71001030007q7211729ahff4e82454454e571@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 2, 2010 at 7:43 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Dec 28, 2009 at 01:18:03PM +0800, Eric Miao wrote:
>> It is not necessary and over-complicated that IRQ_LOCOMO_KEY is a cascaded
>> IRQ of IRQ_LOCOMO_KEY_BASE. Removed and introduced locomokbd_{open,close}
>> for masking/unmasking of the keyboard IRQ.
>
> What about removing these as well:
>
> ? ? ? ?/* install handlers for IRQ_LOCOMO_KEY_BASE generated interrupts */
> ? ? ? ?set_irq_chip(LOCOMO_IRQ_KEY_START, &locomo_key_chip);
> ? ? ? ?set_irq_chip_data(LOCOMO_IRQ_KEY_START, irqbase);
> ? ? ? ?set_irq_handler(LOCOMO_IRQ_KEY_START, handle_edge_irq);
> ? ? ? ?set_irq_flags(LOCOMO_IRQ_KEY_START, IRQF_VALID | IRQF_PROBE);
>
> the locomo_key_chip structure, locomo_key_handler() itself, and the
> associated handlers? ?AFAICS, after this change, none of this is
> used anymore.
>

These are removed in a subsequent patch.
