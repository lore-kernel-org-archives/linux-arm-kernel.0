From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Sep 2011 13:12:43 +0200
Subject: [PATCHv2 05/10] ARM: nomadik: convert to MULTI_IRQ_HANDLER
In-Reply-To: <1317206507-18867-6-git-send-email-jamie@jamieiles.com>
References: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
	<1317206507-18867-6-git-send-email-jamie@jamieiles.com>
Message-ID: <CACRpkdYtHQz8dFbN=LLFNak5dQ5rCoLuM3Jg84D=vibFSpptcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2011 at 12:41 PM, Jamie Iles <jamie@jamieiles.com> wrote:

> - ? ? ? /* This stanza gets the irq mask from one of two status registers */
> - ? ? ? mov ? ? \irqnr, #0
> - ? ? ? ldr ? ? \irqstat, [\base, #VIC_REG_IRQSR0] ? ? ?@ get masked status
> - ? ? ? cmp ? ? \irqstat, #0
> - ? ? ? bne ? ? 1001f
> - ? ? ? add ? ? \irqnr, \irqnr, #32
> - ? ? ? ldr ? ? \irqstat, [\base, #VIC_REG_IRQSR1] ? ? ?@ get masked status

As you can see the Nomadik also has two daisy-chained VICs,
just like the U300, so this also breaks.

Yours,
Linus Walleij
