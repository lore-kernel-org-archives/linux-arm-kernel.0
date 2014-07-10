From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 10 Jul 2014 20:32:49 +0200
Subject: [PATCH 0/3] irqchip: atmel-aic: Add irq RTC fixups
In-Reply-To: <1405016741-2407-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1405016741-2407-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140710203249.23dd6444@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Jul 2014 20:25:38 +0200
Boris BREZILLON <boris.brezillon@free-electrons.com> wrote:

> Hello,
> 
> This patch series introduce the notion of irq fixups for atmel SoCs.
> 
> In most at91 SoCs the first interrupt line is shared by several IPs, and
> some of these HW blocks might be in an unknown state when booting the
> Linux kernel.
> Hence these IPs might generate spurious interrupts if they've not masked
> their irqs and the shared irq line is requested by another peripheral.
> 
> These fixups were previously done in arch/arm/mach-at91/sysirq_mask.c
> but as we're trying to use standard implementation (IRQCHIP_DECLARE and
> automatic call of irqchip_init within arch/arm/kernel/irq.c) we need to
> do those fixups in the irqchip driver.

This is what I was talking about:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/271425.htm


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
