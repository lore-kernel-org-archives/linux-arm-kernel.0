From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 16 Mar 2018 11:39:33 +0100
Subject: [PATCH v2 6/6] arm64: dts: rockchip: enable typec-phy0 for
 rk3399-puma-haikou.
In-Reply-To: <20180301152515.20940-7-enric.balletbo@collabora.com>
References: <20180301152515.20940-1-enric.balletbo@collabora.com>
 <20180301152515.20940-7-enric.balletbo@collabora.com>
Message-ID: <1540740.GPTOZn9kC5@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 1. M?rz 2018, 16:25:15 CET schrieb Enric Balletbo i Serra:
> Commit c301b327aea898af ("arm64: dts: rockchip: add usb3-phy otg-port
> support for rk3399") caused a regression regarding the USB3. During
> boot, the following message appears a few times:
> 
>     dwc3: failed to initialize core
> 
> The driver is deferred waiting for the typec-phy, but this never
> happens beause is disabled. So, enable it.
> 
> Fixes: c301b327aea898af ("arm64: dts: rockchip: add usb3-phy otg-port support for rk3399")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

I've amended the message a bit to clarify that the offending commit
has been reverted for now and this change is needed for reenabling it
and also dropped the Fixes tag.

I've applied the result in my 4.17 branch, but may move that to 4.18
depending on timing. The reenablement of the otg-port will be in
4.18 only anyway.


Heiko
