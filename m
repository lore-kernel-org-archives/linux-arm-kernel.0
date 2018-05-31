From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 31 May 2018 10:03:31 +0200
Subject: [PATCH v4] rtc: sun6i: Fix bit_idx value for clk_register_gate
In-Reply-To: <20180530182744.27611-1-jagan@amarulasolutions.com>
References: <20180530182744.27611-1-jagan@amarulasolutions.com>
Message-ID: <20180531080331.5onjtjmxfolzbtc2@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 11:57:44PM +0530, Jagan Teki wrote:
> From: Michael Trimarchi <michael@amarulasolutions.com>
> 
> clk-gate core will take bit_idx through clk_register_gate
> and then do clk_gate_ops by using BIT(bit_idx), but rtc-sun6i
> is passing bit_idx as BIT(bit_idx) it becomes BIT(BIT(bit_idx)
> which is wrong and eventually external gate clock is not enabling.
> 
> This patch fixed by passing bit index and the original change
> introduced from below commit.
> "rtc: sun6i: Add support for the external oscillator gate"
> (sha1: 	17ecd246414b3a0fe0cb248c86977a8bda465b7b)
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Fixes: 17ecd246414b ("rtc: sun6i: Add support for the external oscillator gate")
> Cc: stable at vger.kernel.org
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
