From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 16 Mar 2018 11:39:06 +0100
Subject: [PATCH v2 5/6] arm64: dts: rockchip: enable typec-phy1 for
 rk3399-puma.
In-Reply-To: <20180301152515.20940-6-enric.balletbo@collabora.com>
References: <20180301152515.20940-1-enric.balletbo@collabora.com>
 <20180301152515.20940-6-enric.balletbo@collabora.com>
Message-ID: <6587891.VFllPVjdJl@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 1. M?rz 2018, 16:25:14 CET schrieb Enric Balletbo i Serra:
> Commit c301b327aea898af ("arm64: dts: rockchip: add usb3-phy otg-port
> support for rk3399") caused a regression regarding the USB3. During boot,
> the following message appears a few times:
> 
>       dwc3: failed to initialize core
> 
> The driver is deferred waiting for the typec-phy, but this never happens
> beause is disabled. So, enable it.
> 
> Fixes: c301b327aea898af ("arm64: dts: rockchip: add usb3-phy otg-port support for rk3399")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

[Same blurb as in patch 3/6]
I've amended the message a bit to clarify that the offending commit
has been reverted for now and this change is needed for reenabling it
and also dropped the Fixes tag.

I've also moved the node to a better place - if in doubt please sort
the "&foo {" things alphabetically.

I've applied the result in my 4.17 branch, but may move that to 4.18
depending on timing. The reenablement of the otg-port will be in
4.18 only anyway.


Heiko
