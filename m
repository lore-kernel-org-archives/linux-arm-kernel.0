From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 14 Mar 2018 09:14:43 +0100
Subject: [PATCH v2 1/6] phy: rockchip-typec: fall back to working in
 host-mode if extcon is missing.
In-Reply-To: <20180301152515.20940-2-enric.balletbo@collabora.com>
References: <20180301152515.20940-1-enric.balletbo@collabora.com>
 <20180301152515.20940-2-enric.balletbo@collabora.com>
Message-ID: <20019382.PXhIOVQJGo@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,

Am Donnerstag, 1. M?rz 2018, 16:25:10 CET schrieb Enric Balletbo i Serra:
> Right now the rockchip type-c phy does fail probing when no extcon is
> detected. Some boards get the cable-state via the extcon interface and
> have this supported, other boards seem to use the fusb302 chip or
> another but the driver currently does not seem to utilize the extcon
> interface to report the cable-state. And, other, just connect the type-c
> to a standard USB-A port so use no controller at all. A missing extcon
> shouldn't fail to probe, instead, should just fall back to working in
> host-mode if it cannot get the extcon.
> 
> Fixes: c301b327aea898af ("arm64: dts: rockchip: add usb3-phy otg-port
> support for rk3399") Reported-by: Vicente Bergas <vicencb@gmail.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

I did revert the original commit mentioned in the fixes tag for 4.16-rc
but it would nevertheless be really cool if these 2 patches (code + binding)
could make it into your tree for 4.17 :-)

And ideally also with the other 5 patches from Enric starting at
	[PATCH v3 1/6] phy: rockchip-typec: deprecate some DT properties for various register fields.

from 2018-02-16.


Thanks
Heiko
