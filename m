From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 16 Mar 2018 11:29:59 +0530
Subject: [PATCH v2 1/6] phy: rockchip-typec: fall back to working in
 host-mode if extcon is missing.
In-Reply-To: <20019382.PXhIOVQJGo@diego>
References: <20180301152515.20940-1-enric.balletbo@collabora.com>
 <20180301152515.20940-2-enric.balletbo@collabora.com>
 <20019382.PXhIOVQJGo@diego>
Message-ID: <32f24fca-7d89-6edf-26a4-8dc7d1d1ea31@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 14 March 2018 01:44 PM, Heiko St?bner wrote:
> Hi Kishon,
> 
> Am Donnerstag, 1. M?rz 2018, 16:25:10 CET schrieb Enric Balletbo i Serra:
>> Right now the rockchip type-c phy does fail probing when no extcon is
>> detected. Some boards get the cable-state via the extcon interface and
>> have this supported, other boards seem to use the fusb302 chip or
>> another but the driver currently does not seem to utilize the extcon
>> interface to report the cable-state. And, other, just connect the type-c
>> to a standard USB-A port so use no controller at all. A missing extcon
>> shouldn't fail to probe, instead, should just fall back to working in
>> host-mode if it cannot get the extcon.
>>
>> Fixes: c301b327aea898af ("arm64: dts: rockchip: add usb3-phy otg-port
>> support for rk3399") Reported-by: Vicente Bergas <vicencb@gmail.com>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> 
> I did revert the original commit mentioned in the fixes tag for 4.16-rc
> but it would nevertheless be really cool if these 2 patches (code + binding)
> could make it into your tree for 4.17 :-)
> 
> And ideally also with the other 5 patches from Enric starting at
> 	[PATCH v3 1/6] phy: rockchip-typec: deprecate some DT properties for various register fields.
> 
> from 2018-02-16.

merged now, thanks!

-Kishon
