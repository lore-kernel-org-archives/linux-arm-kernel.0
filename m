From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Sep 2011 13:15:32 +0200
Subject: [PATCHv2 03/10] ARM: ep93xx: convert to MULTI_IRQ_HANDLER
In-Reply-To: <1317206507-18867-4-git-send-email-jamie@jamieiles.com>
References: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
	<1317206507-18867-4-git-send-email-jamie@jamieiles.com>
Message-ID: <CACRpkdatMdg3cbEqwnNpNjKrzf=r_+xi9U0XiyqcRbRuvz8zYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2011 at 12:41 PM, Jamie Iles <jamie@jamieiles.com> wrote:

> - ? ? ? ? ? ? ? .macro ?get_irqnr_and_base, irqnr, irqstat, base, tmp
> - ? ? ? ? ? ? ? ldr ? ? \base, =(EP93XX_AHB_VIRT_BASE)
> - ? ? ? ? ? ? ? orr ? ? \base, \base, #0x000b0000
> - ? ? ? ? ? ? ? mov ? ? \irqnr, #0
> - ? ? ? ? ? ? ? ldr ? ? \irqstat, [\base] ? ? ? ? ? ? ? @ lower 32 interrupts
> - ? ? ? ? ? ? ? cmp ? ? \irqstat, #0
> - ? ? ? ? ? ? ? bne ? ? 1001f
> -
> - ? ? ? ? ? ? ? eor ? ? \base, \base, #0x00070000
> - ? ? ? ? ? ? ? ldr ? ? \irqstat, [\base] ? ? ? ? ? ? ? @ upper 32 interrupts
> - ? ? ? ? ? ? ? cmp ? ? \irqstat, #0
> - ? ? ? ? ? ? ? beq ? ? 1002f
> - ? ? ? ? ? ? ? mov ? ? \irqnr, #0x20

Two VIC instances again...

Yours,
Linus Walleij
