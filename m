From: robh@kernel.org (Rob Herring)
Date: Mon, 3 Oct 2016 13:57:13 -0500
Subject: [PATCH 4/8] pinctrl: aspeed-g5: Fix pin association of SPI1
 function
In-Reply-To: <bdd34f8c4bfabbc1d3cd05a66ac8734da514b1e5.1474986045.git-series.andrew@aj.id.au>
References: <cover.115463f791b69859c5ce9dafd61a5755ea039f4b.1474986045.git-series.andrew@aj.id.au>
 <bdd34f8c4bfabbc1d3cd05a66ac8734da514b1e5.1474986045.git-series.andrew@aj.id.au>
Message-ID: <20161003185713.GA30227@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2016 at 12:20:16AM +0930, Andrew Jeffery wrote:
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
> ---
>  Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt |  4 +-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c                   | 86 ++++++-
>  2 files changed, 81 insertions(+), 9 deletions(-)
