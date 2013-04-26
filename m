From: coelho@ti.com (Luciano Coelho)
Date: Fri, 26 Apr 2013 16:23:23 +0300
Subject: [PATCH 2/3] ARM: dts: Add muxing for wl12xx on the SDIO bus for
 pandaboard
In-Reply-To: <20130426035213.26065.63243.stgit@muffinssi.local>
References: <20130426034858.26065.65118.stgit@muffinssi.local>
 <20130426035213.26065.63243.stgit@muffinssi.local>
Message-ID: <1366982603.4029.42.camel@cumari.coelho.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-04-25 at 20:52 -0700, Tony Lindgren wrote:
> This is needed to get wl12xx working with device tree based
> booting.
> 
> Note that we claim the various GPIO inputs in the regulator
> as the proper muxing is needed to enable and disable the
> regulator.
> 
> Also, we want to use non-removable instead of ti,non-removable
> as the ti,non-removable also sets no_regulator_off_init which
> is really not what we want as then wl12xx won't get powered
> up and down which is needed for resetting it.
> 
> Cc: Luciano Coelho <coelho@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: devicetree-discuss at lists.ozlabs.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

I tried this now and it seems to work fine too.  So:

Tested-by: Luciano Coelho <coelho@ti.com>

Except that with linux-next I'm getting some problems with the
interrupts when trying to use wl12xx.  It's not related to this patch
though, and I'm investigating it right now.

Also, I found one small whitespace problem in this patch:

[...]
> +	/* wl12xx GPIO inputs and SDIO pins */
> +	wl12xx_pins: pinmux_wl12xx_pins {
> +		pinctrl-single,pins = <
> +			0x38 0x103	/* gpmc_ncs2.gpio_52 INPUT | MODE3 */
> +			0x3a 0x103	/* gpmc_ncs3.gpio_53 INPUT | MODE3 */
> +			0x108 0x118	/* sdmmc5_clk.sdmmc5_clk INPUT_PULLUP | MODE0 */
> +			0x10a 0x118	/* sdmmc5_cmd.sdmmc5_cmd INPUT_PULLUP | MODE0 */
> +			0x10c 0x118	/* sdmmc5_dat0.sdmmc5_dat0 INPUT_PULLUP | MODE0 */
> +			0x10e 0x118	/* sdmmc5_dat1.sdmmc5_dat1 INPUT_PULLUP | MODE0 */
> +			0x110 0x118	/* sdmmc5_dat2.sdmmc5_dat2 INPUT_PULLUP | MODE0 */
> +			0x112 0x118	/* sdmmc5_dat3.sdmmc5_dat3 INPUT_PULLUP | MODE0 */
> +      		>;

git am reports a "space before tab in indent" here.


-- 
Luca.
