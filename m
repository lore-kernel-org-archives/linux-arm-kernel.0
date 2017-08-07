From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 07 Aug 2017 14:41:57 -0700
Subject: [PATCH 13/14] mmc: meson-gx: work around clk-stop issue
In-Reply-To: <20170804174353.16486-14-jbrunet@baylibre.com> (Jerome Brunet's
 message of "Fri, 4 Aug 2017 19:43:52 +0200")
References: <20170804174353.16486-1-jbrunet@baylibre.com>
 <20170804174353.16486-14-jbrunet@baylibre.com>
Message-ID: <7hzibbnjh6.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> It seems that the signal clock is also used and required, somehow, by
> the controller it self.
>
> It is shown during init, when writing to CFG while the divider is set
> to 0 will crash the SoC. During voltage switch, the controller may crash
> and the card may then fail to exit busy state if the clock is stopped.
>
> To avoid this, it is best to keep the clock running for the controller,
> except during rate change. However, we still need to be able to gate
> the clock out of the SoC. Let's use the pinmux for this, and fallback
> to gpio mode (pulled-down) when we need to gate the clock
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Curious "feature" of the IP, but the solution looks good to me.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

Kevin
