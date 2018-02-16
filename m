From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 16 Feb 2018 16:34:42 +0530
Subject: [PATCH 0/4] Move DP phy switch to PHY driver
In-Reply-To: <1486712654-15431-1-git-send-email-zyw@rock-chips.com>
References: <1486712654-15431-1-git-send-email-zyw@rock-chips.com>
Message-ID: <a9eac594-33d5-6171-51ca-66204008fc1f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 10 February 2017 01:14 PM, Chris Zhong wrote:
> 
> There are 2 Type-c PHYs in RK3399, but only one DP controller. Hence
> only one PHY can connect to DP controller at one time, the other should
> be disconnected. The GRF_SOC_CON26 register has a switch bit to do it,
> set this bit means enable PHY 1, clear this bit means enable PHY 0.
> 
> If the board has 2 Type-C ports, the DP driver get the phy id from
> devm_of_phy_get_by_index, and then control this switch according to
> this id. But some others board only has one Type-C port, it may be PHY 0
> or PHY 1. The dts node id can not tell us the correct PHY id. Hence move
> this switch to PHY driver, the PHY driver can distinguish between PHY 0
> and PHY 1, and then write the correct register bit.
> 
> 

Changed subject of "Documentation: bindings: add uphy-dp-sel for Rockchip USB
Type-C PHY" as suggested by Rob, rebased "phy: rockchip-typec: support DP phy
switch" to the latest kernel and merged.

Thanks
Kishon

> 
> Chris Zhong (4):
>   Documentation: bindings: add uphy-dp-sel for Rockchip USB Type-C PHY
>   arm64: dts: rockchip: add rockchip,uphy-dp-sel for Type-C phy
>   phy: rockchip-typec: support DP phy switch
>   drm/rockchip: cdn-dp: remove the DP phy switch
> 
>  Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt | 5 +++++
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi                     | 2 ++
>  drivers/gpu/drm/rockchip/cdn-dp-core.c                       | 7 -------
>  drivers/phy/phy-rockchip-typec.c                             | 9 +++++++++
>  4 files changed, 16 insertions(+), 7 deletions(-)
> 
