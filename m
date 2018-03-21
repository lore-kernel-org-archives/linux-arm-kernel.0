From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 21 Mar 2018 14:29:25 +0100
Subject: [PATCH 2/3] arm64: dts: armada-3720-espressobin: make use of
 switch irq line
In-Reply-To: <20180321132345.psrs3n7whpjdabeo@pengutronix.de>
References: <20180321105005.18426-1-u.kleine-koenig@pengutronix.de>
 <20180321105005.18426-2-u.kleine-koenig@pengutronix.de>
 <20180321131536.GC11206@lunn.ch>
 <20180321132345.psrs3n7whpjdabeo@pengutronix.de>
Message-ID: <20180321132925.GF11206@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> . So I guess this has to change to
> 
> +               interrupt-parent = <&gpiosb>;
> +		/* actually the irq is active low, but gpiosb doesn't support that and falling edge seems to work just fine */
> +               interrupts = <23 IRQ_TYPE_EDGE_FALLING>;

Or wait until you have simulated level interrupts?

At the moment, without this patch, you should have driver polled
interrupts. That already gives you a good speedup over phylib polling
the PHYs.

    Andrew
