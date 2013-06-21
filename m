From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 21 Jun 2013 15:19:51 -0600
Subject: [PATCH] clk: tegra: provide tegra_periph_reset_assert alternative
In-Reply-To: <201306212232.27026.arnd@arndb.de>
References: <201306212232.27026.arnd@arndb.de>
Message-ID: <51C4C377.5090408@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/21/2013 02:32 PM, Arnd Bergmann wrote:
> We have some tegra device drivers that are written to be platform
> independent but still use the tegra specific tegra_periph_reset_assert
> function. In order to build and link them without errors,
> this provides a static inline version of these functions that
> does nothing when Tegra support is disabled.

Oh, I thought this had been applied already.

Acked-by: Stephen Warren <swarren@nvidia.com>

Hopefully we'll be replacing these custom APIs with the standard module
reset APIs soon (post 3.11 though). I've seen internally the first round
of patches from Prashant for this, so chances are good they'll be
finalized and sent upstream in the not-too-distant future.
