From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 May 2011 19:10:32 +0200
Subject: On __raw_readl readl_relaxed and readl nocheinmal
In-Reply-To: <20110527163827.GF14035@e102109-lin.cambridge.arm.com>
References: <BANLkTi=UiJ_SYOjcv+WuJ70LLQhvpQs2Wg@mail.gmail.com>
	<201105271816.10191.arnd@arndb.de>
	<20110527163827.GF14035@e102109-lin.cambridge.arm.com>
Message-ID: <201105271910.32946.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 May 2011 18:38:29 Catalin Marinas wrote:
> As I said above, that's not a simple case and you could still get a
> spurious interrupt. Based on feedback from the hw people, even if you
> lower the interrupt level at the device (by writing and reading back
> from the device), there is a delay in the signal propagation and
> enabling the interrupts at the CPU level (or interrupt controller level)
> could still trigger the interrupt. You can add extra delay to reduce the
> chances but that's SoC specific. Anyway, reading back from the device
> makes the likelihood much smaller.

Ah, right. I was thinking of message signaled interrupts, but they
are probably not so common on ARM. With MSI, the interrupt message
would also get flushed by the readl().

	Arnd
