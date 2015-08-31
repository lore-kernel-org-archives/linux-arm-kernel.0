From: anders.roxell@linaro.org (Anders Roxell)
Date: Mon, 31 Aug 2015 23:28:44 +0200
Subject: [PATCH] drivers: i2c: exynos5: irq spinlock rt-safe
In-Reply-To: <alpine.DEB.2.11.1508252349070.15006@nanos>
References: <1440489125-20082-1-git-send-email-anders.roxell@linaro.org>
 <alpine.DEB.2.11.1508252349070.15006@nanos>
Message-ID: <20150831212844.GI13774@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-08-25 23:51, Thomas Gleixner wrote:
> On Tue, 25 Aug 2015, Anders Roxell wrote:
> 
> > The exynos5_i2c_message_start enables interrupts while holding the i2c
> > lock which is sought by the irq handler. If an IRQ is received before
> > this lock is released then a deadlock occurs.
> 
> That's crap. The interrupt handler runs in an irq thread as RT forces
> all normal interrupts to that.

You are right, I will send a v2 with a better changelog.

Cheers,
Anders
