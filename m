From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 9 Mar 2018 23:18:53 +0800
Subject: [PATCH 0/2] hwrng: omap: Fix clock resource for Armada 7K/8K
In-Reply-To: <20180228142723.11562-1-gregory.clement@bootlin.com>
References: <20180228142723.11562-1-gregory.clement@bootlin.com>
Message-ID: <20180309151853.GF13567@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 03:27:21PM +0100, Gregory CLEMENT wrote:
> Hi,
> 
> This short series fixes the way the clocks are used for the SafeXcel
> IP-76 controller embedded in the Marvell Armada 7K/8K SoCs. On these
> SoCs a second one is needed in order to clock the registers. It was
> not noticed until now because we relied on the bootloader and also
> because the clock driver was wrong.
> 
> Thanks to this fix, it would be possible to fix the clock driver
> without introducing a regression.
> 
> The first patch is just a small cleanup found when I wrote the main
> patch.
> 
> Gregory CLEMENT (2):
>   hwrng: omap - Remove useless test before clk_disable_unprepare
>   hwrng: omap - Fix clock resource by adding a register clock
> 
>  Documentation/devicetree/bindings/rng/omap_rng.txt |  7 ++++++-
>  drivers/char/hw_random/omap-rng.c                  | 22 ++++++++++++++++++----
>  2 files changed, 24 insertions(+), 5 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
