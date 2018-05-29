From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 29 May 2018 18:06:47 +0200
Subject: [PATCH v2] rtc: sun6i: Fix bit_idx value for clk_register_gate
In-Reply-To: <20180529160425.23697-1-jagan@amarulasolutions.com>
References: <20180529160425.23697-1-jagan@amarulasolutions.com>
Message-ID: <20180529160647.ene36dc7iacyppia@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 09:34:25PM +0530, Jagan Teki wrote:
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
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

I said it in the v1 already, but this should be sent to stable and
have a fixes tag.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
