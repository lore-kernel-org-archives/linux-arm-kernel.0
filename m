From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 29 Sep 2011 08:55:08 +0200
Subject: [PATCHv2 02/10] ARM: vic: MULTI_IRQ_HANDLER handler
In-Reply-To: <20110928203905.GB2838@ponder.secretlab.ca>
References: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
	<1317206507-18867-3-git-send-email-jamie@jamieiles.com>
	<20110928203905.GB2838@ponder.secretlab.ca>
Message-ID: <CACRpkdZKns-GraGp-YMD6jzOPETkvEpt9bC8HcYUmf3JUyCV3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2011 at 10:39 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:

> Why isn't it simply written this way:
>
> ? ? ? ?stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
> ? ? ? ?while (stat) {
> ? ? ? ? ? ? ? ?irq = fls(stat) - 1;
> ? ? ? ? ? ? ? ?handle_IRQ(irq_domain_to_irq(&vic->domain, irq), regs);
> ? ? ? ? ? ? ? ?stat &= ~(1 << irq);
> ? ? ? ?}

That is indeed closer to the assembly loop most platforms have
implemented.

Jamie can you test this approach? And also use ffs() insteadof
fls()...

Thanks,
Linus Walleij
