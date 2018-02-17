From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 17 Feb 2018 01:09:52 +0100
Subject: [PATCH v3 4/6] phy: rockchip-typec: force to USB2 if DP at 4
 lanes mode
In-Reply-To: <20180216120956.19034-4-enric.balletbo@collabora.com>
References: <20180216120956.19034-1-enric.balletbo@collabora.com>
 <20180216120956.19034-4-enric.balletbo@collabora.com>
Message-ID: <4816286.2JUx8CKC3E@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 16. Februar 2018, 13:09:54 CET schrieb Enric Balletbo i Serra:
> From: Chris Zhong <zyw@rock-chips.com>
> 
> The usb3tousb2_en BIT will be clear to 0 in probe(), it make USB
> controller work at USB3 mode, and if the USB phy is turned on with DP
> only mode(4 lanes DP), the rockchip_usb3_phy_power_on() will return
> directly, so usb3_host_disable and usb3_host_port these 2 BIT will keep
> a same value as coreboot. In coreboot, these 3 BITs are set as USB2
> mode, but now one of the bits is changed to USB3, it make USB controller
> work at a unknown status.
> 
> These 3 BITs should be changed to USB2, if the Type-C works at 4 lanes
> mode, and then switch it back to USB3 mode, when USB disconnect.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
