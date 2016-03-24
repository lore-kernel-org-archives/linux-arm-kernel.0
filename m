From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 24 Mar 2016 14:01:33 +0100
Subject: [PATCH v14 0/17] Add Analogix Core Display Port Driver
In-Reply-To: <1455534485-1154-1-git-send-email-ykk@rock-chips.com>
References: <1455534485-1154-1-git-send-email-ykk@rock-chips.com>
Message-ID: <14744174.gBEQWZv0K7@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 15. Februar 2016, 19:08:05 schrieb Yakir Yang:
> Hi all,
> 
>   The Samsung Exynos eDP controller and Rockchip RK3288 eDP controller
> share the same IP, so a lot of parts can be re-used. I split the common
> code into bridge directory, then rk3288 and exynos only need to keep
> some platform code. Cause I can't find the exact IP name of exynos dp
> controller, so I decide to name dp core driver with "analogix" which I
> find in rk3288 eDP TRM
> 
> But there are still three light registers setting different between
> exynos and rk3288.
> 1. RK3288 have five special pll registers which not indicate in exynos
>    dp controller.
> 2. The address of DP_PHY_PD(dp phy power manager register) are different
>    between rk3288 and exynos.
> 3. Rk3288 and exynos have different setting with AUX_HW_RETRY_CTL(dp debug
>    register).
> 
> Due to Mark Yao have introduced the ATOMIC support to Rockchip drm, so it's
> okay to use the ATOMIC helpers functions in connector_funcs. No need to
> splict the connector init to platform driver anymore, and this is the
> biggest change since version 11.
> 
> This v14 didn't have lots of new changes which seems not the correct time to
> upgrade the version number, but I have changed ordering of patches (adding
> 2 more, and removing 2 out). Especially to prevent confusing people, so I
> updated the whole series.

I guess I never said that explicitly, but of course I have tested this 
numerous times, so

This series
Tested-by: Heiko Stuebner <heiko@sntech.de>
