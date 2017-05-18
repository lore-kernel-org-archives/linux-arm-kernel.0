From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Thu, 18 May 2017 08:32:31 +0800
Subject: [PATCH] phy-rockchip-pcie: Mark phy_rd_cfg() as __maybe_unused
In-Reply-To: <20170517230316.191259-1-mka@chromium.org>
References: <20170517230316.191259-1-mka@chromium.org>
Message-ID: <07fa771b-dd7b-a324-143b-4784fbb697fb@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On 2017/5/18 7:03, Matthias Kaehlcke wrote:
> The function is not used, but is probably kept around for debugging and
> symmetry with phy_wr_cfg(). Adding the attribute fixes the following
> warning when building with clang:
>
> drivers/phy/phy-rockchip-pcie.c:102:19: error: unused function
>     'phy_rd_cfg' [-Werror,-Wunused-function]
>

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks.

> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/phy/phy-rockchip-pcie.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/phy/phy-rockchip-pcie.c b/drivers/phy/phy-rockchip-pcie.c
> index 6904633cad68..f8c6846094c0 100644
> --- a/drivers/phy/phy-rockchip-pcie.c
> +++ b/drivers/phy/phy-rockchip-pcie.c
> @@ -99,8 +99,8 @@ static inline void phy_wr_cfg(struct rockchip_pcie_phy *rk_phy,
>  				   PHY_CFG_WR_SHIFT));
>  }
>
> -static inline u32 phy_rd_cfg(struct rockchip_pcie_phy *rk_phy,
> -			     u32 addr)
> +static inline u32 __maybe_unused
> +phy_rd_cfg(struct rockchip_pcie_phy *rk_phy, u32 addr)
>  {
>  	u32 val;
>
>
