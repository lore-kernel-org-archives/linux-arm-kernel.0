From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 16 Mar 2018 12:02:53 +0100
Subject: [PATCH v3 6/6] drm/rockchip: cdn-dp: remove the DP phy switch
In-Reply-To: <20180216120956.19034-6-enric.balletbo@collabora.com>
References: <20180216120956.19034-1-enric.balletbo@collabora.com>
 <20180216120956.19034-6-enric.balletbo@collabora.com>
Message-ID: <1866837.JGGNoqQO1N@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 16. Februar 2018, 13:09:56 CET schrieb Enric Balletbo i Serra:
> From: Chris Zhong <zyw@rock-chips.com>
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
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

applied to drm-misc with a note stating where the rest of the series
went to.

Thanks
Heiko
