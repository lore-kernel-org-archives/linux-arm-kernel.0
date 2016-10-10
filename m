From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Oct 2016 09:59:05 +0200
Subject: [PATCH 4/8] pinctrl: aspeed-g5: Fix pin association of SPI1
 function
In-Reply-To: <bdd34f8c4bfabbc1d3cd05a66ac8734da514b1e5.1474986045.git-series.andrew@aj.id.au>
References: <cover.115463f791b69859c5ce9dafd61a5755ea039f4b.1474986045.git-series.andrew@aj.id.au>
 <bdd34f8c4bfabbc1d3cd05a66ac8734da514b1e5.1474986045.git-series.andrew@aj.id.au>
Message-ID: <CACRpkdaq63o_LFgoocYfPMKf4fVVSvJZnp3t9Wu2XBkKb0Lrdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2016 at 4:50 PM, Andrew Jeffery <andrew@aj.id.au> wrote:

> The SPI1 function was associated with the wrong pins: The functions that
> those pins provide is either an SPI debug or passthrough function
> coupled to SPI1. Make the SPI1 mux function configure the relevant pins
> and associate new SPI1DEBUG and SPI1PASSTHRU functions with the pins
> that were already defined.
>
> The notation used in the datasheet's multi-function pin table for the SoC is
> often creative: in this case the SYS* signals are enabled by a single bit,
> which is nothing unusual on its own, but in this case the bit was also
> participating in a multi-bit bitfield and therefore represented multiple
> functions. This fact was overlooked in the original patch.
>
> Fixes: 56e57cb6c07f (pinctrl: Add pinctrl-aspeed-g5 driver)
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Patch applied for fixes.

Yours,
Linus Walleij
