From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 08 Jun 2015 19:56:07 -0600
Subject: [PATCH v3 2/7] ARM: bcm2835: Add a Raspberry Pi-specific clock
 driver.
In-Reply-To: <1433807940-15328-2-git-send-email-eric@anholt.net>
References: <1433807940-15328-1-git-send-email-eric@anholt.net>
 <1433807940-15328-2-git-send-email-eric@anholt.net>
Message-ID: <557647B7.2030302@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2015 05:58 PM, Eric Anholt wrote:
> Unfortunately, the clock manager's registers are not accessible by the
> ARM, so we have to request that the firmware modify our clocks for us.
> 
> This driver only registers the clocks at the point they are requested
> by a client driver.  This is partially to support returning
> -EPROBE_DEFER when the firmware driver isn't supported yet, but it
> also avoids issues with disabling "unused" clocks due to them not yet
> being connected to their consumers in the DT.

> diff --git a/drivers/clk/clk-raspberrypi.c b/drivers/clk/clk-raspberrypi.c

> +static int rpi_clk_set_state(struct clk_hw *hw, bool on)

> +	if (ret || (packet[1] & (1 << 1))) {

A #define for the shift amount would be nice, so that this statement was
a bit more semantic.

Aside from that, the series,
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
