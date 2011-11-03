From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 3 Nov 2011 14:00:15 +0100
Subject: [PATCHv2 02/10] ARM: vic: MULTI_IRQ_HANDLER handler
In-Reply-To: <20111103125136.GL12913@n2100.arm.linux.org.uk>
References: <1317206507-18867-1-git-send-email-jamie@jamieiles.com>
	<1317206507-18867-3-git-send-email-jamie@jamieiles.com>
	<20110928203905.GB2838@ponder.secretlab.ca>
	<CACRpkdZKns-GraGp-YMD6jzOPETkvEpt9bC8HcYUmf3JUyCV3A@mail.gmail.com>
	<20110929093009.GM17204@pulham.picochip.com>
	<20111102134024.GE19187@n2100.arm.linux.org.uk>
	<20111102140811.GA22491@totoro>
	<CACRpkdY+EBkHfupO5T4SYKPxzX2L2kr8fLVMJK=JctNeYAzn2g@mail.gmail.com>
	<20111103125136.GL12913@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdZ1qfVduMAmusNoLjDoqy2kDA4crN__iW9qEeXBgVT4cA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 3, 2011 at 1:51 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> ? ? ? ?stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
> ? ? ? ?while (stat) {
> ? ? ? ? ? ? ? ?while (stat) {
> ? ? ? ? ? ? ? ? ? ? ? ?irq = ffs(stat) - 1;
> ? ? ? ? ? ? ? ? ? ? ? ?stat &= ~(1 << irq);
> ? ? ? ? ? ? ? ? ? ? ? ?handle_irq(irq);
> ? ? ? ? ? ? ? ?}
> ? ? ? ? ? ? ? ?stat = readl_relaxed(vic->base + VIC_IRQ_STATUS);
> ? ? ? ?}
>
> This ensures that we process all interrupts found pending before we
> re-check for any new interrupts pending. ?Arguably this is a much
> fairer implementation (and may mean if things get irrevokably stuck,
> things like sysrq via the console uart may still work.)

I really like the looks of this, Jamie can you do it like that?

Maybe some smallish comment about what's going on can be
good for future generations reading that code...

Yours,
Linus Walleij
