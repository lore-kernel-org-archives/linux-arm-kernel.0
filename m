From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 May 2018 10:08:20 -0700
Subject: [PATCH] arm: omap1: ams-delta: fix deferred_fiq handler
In-Reply-To: <20180502183203.16034-1-jmkrzyszt@gmail.com>
References: <20180502183203.16034-1-jmkrzyszt@gmail.com>
Message-ID: <20180503170820.GW98604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [180502 11:34]:
> The deferred_fiq handler used to limit hardware operations to IRQ
> unmask only, relying on gpio-omap assigned handler performing the ACKs.
> Since commit 80ac93c27441 ("gpio: omap: Fix lost edge interrupts") this
> is no longer the case as handle_edge_irq() has been replaced with
> handle_simmple_irq() which doesn't touch the hardware.
> 
> Add single ACK operation per each active IRQ pin to the handler. While
> being at it, move unmask operation out of irq_counter loop so it is
> also called only once for each active IRQ pin.

Good to hear the fiq handler is confirmed working, applying
into omap-for-v4.17/fixes thanks.

Tony
