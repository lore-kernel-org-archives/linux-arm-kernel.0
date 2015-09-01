From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 01 Sep 2015 23:47:35 +0200
Subject: [PATCH v4 0/16] Add Analogix Core Display Port Driver
In-Reply-To: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
Message-ID: <3233920.KG0buE86B2@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yakir,

Am Dienstag, 1. September 2015, 13:46:11 schrieb Yakir Yang:
>    The Samsung Exynos eDP controller and Rockchip RK3288 eDP controller
> share the same IP, so a lot of parts can be re-used. I split the common
> code into bridge directory, then rk3288 and exynos only need to keep
> some platform code. Cause I can't find the exact IP name of exynos dp
> controller, so I decide to name dp core driver with "analogix" which I
> find in rk3288 eDP TRM ;)
> 
> Beyond that, there are three light registers setting differents bewteen
> exynos and rk3288.
> 1. RK3288 have five special pll resigters which not indicata in exynos
>    dp controller.
> 2. The address of DP_PHY_PD(dp phy power manager register) are different
>    between rk3288 and exynos.
> 3. Rk3288 and exynos have different setting with AUX_HW_RETRY_CTL(dp debug
>    register).
> 
> I have verified this series on two kinds of rockchip platform board, one
> is rk3288 sdk board which connect with a 2K display port monitor, the other
> is google jerry chromebook which connect with a eDP screen "cnm,n116bgeea2",
> both of them works rightlly.

it looks like during the rebase something did go wrong and I found some issues 
I mentioned in the replies to individual patches.

I did prepare a branch based on mainline [0] with both the old and the new edp 
driver - rk3288_veyron_defconfig build both drivers into the image.

While the old driver still works, I wasn't able to make the new one work yet 
... the drm core does find the connector, but not that anything is connected 
to it. I'll try to dig deeper tomorrow, but maybe you'll see anything 
interesting before then.


Heiko

[0] https://github.com/mmind/linux-rockchip/tree/tmp/edp-with-veyron
