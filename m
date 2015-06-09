From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 9 Jun 2015 15:17:15 +0200 (CEST)
Subject: [IRQ] Buggy driver makes __setup_irq segfault
In-Reply-To: <5576E457.6020805@free.fr>
References: <5576E457.6020805@free.fr>
Message-ID: <alpine.DEB.2.11.1506091515060.4133@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 9 Jun 2015, Mason wrote:
> I'm a noob, so I suppose this behavior is expected, but I'm reporting it,
> just in case. (I tested with 3.14.41)
> 
> Consider this buggy driver, calling request_irq() multiple times,
> and not calling free_irq in the cleanup routine.

Not freeing things in the module exit code will make stuff explode,
not only interrupts. So yes, it's expected behaviour.

Thanks,

	tglx
