From: davem@davemloft.net (David Miller)
Date: Tue, 10 Dec 2013 18:01:38 -0500 (EST)
Subject: [PATCH v2] net: allwinner: emac: Add missing free_irq
In-Reply-To: <1386700849-8496-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1386700849-8496-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20131210.180138.15284905537878885.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 10 Dec 2013 19:40:43 +0100

> The sun4i-emac driver uses devm_request_irq at .ndo_open time, but relies on
> the managed device mechanism to actually free it. This causes an issue whenever
> someone wants to restart the interface, the interrupt still being held, and not
> yet released.
> 
> Fall back to using the regular request_irq at .ndo_open time, and introduce a
> free_irq during .ndo_stop.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied, thanks.
