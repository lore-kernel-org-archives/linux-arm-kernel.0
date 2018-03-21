From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 21 Mar 2018 14:15:36 +0100
Subject: [PATCH 2/3] arm64: dts: armada-3720-espressobin: make use of
 switch irq line
In-Reply-To: <20180321105005.18426-2-u.kleine-koenig@pengutronix.de>
References: <20180321105005.18426-1-u.kleine-koenig@pengutronix.de>
 <20180321105005.18426-2-u.kleine-koenig@pengutronix.de>
Message-ID: <20180321131536.GC11206@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2018 at 11:50:04AM +0100, Uwe Kleine-K?nig wrote:
> The switch's INTn line is connected to the CPU's MPP2_23 pad. Wire this
> up in the device tree. Note however that up to now the
> marvell,armada3710-sb-pinctrl driver doesn't support level irqs, so the
> switch driver doesn't make use of this feature.

Hi Uwe

So that actually happens here, if the interrupt cannot be used? I
assume the mv88e6xxx driver does not fail the probe because the IRQ
cannot be configured? What does happen?

Thanks
	Andrew
