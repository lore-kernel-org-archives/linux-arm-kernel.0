From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 25 Aug 2015 23:51:50 +0200 (CEST)
Subject: [PATCH] drivers: i2c: exynos5: irq spinlock rt-safe
In-Reply-To: <1440489125-20082-1-git-send-email-anders.roxell@linaro.org>
References: <1440489125-20082-1-git-send-email-anders.roxell@linaro.org>
Message-ID: <alpine.DEB.2.11.1508252349070.15006@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Aug 2015, Anders Roxell wrote:

> The exynos5_i2c_message_start enables interrupts while holding the i2c
> lock which is sought by the irq handler. If an IRQ is received before
> this lock is released then a deadlock occurs.

That's crap. The interrupt handler runs in an irq thread as RT forces
all normal interrupts to that.

Thanks,

	tglx

 
