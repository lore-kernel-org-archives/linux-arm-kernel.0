From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 10 Feb 2016 00:32:51 +0100
Subject: [PATCH] ARM: dts: rockchip: replace gpio-key,
 wakeup with wakeup-source property
In-Reply-To: <1454968512-11956-1-git-send-email-sudeep.holla@arm.com>
References: <1454968512-11956-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <48510660.EJbbczq5fX@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

Am Montag, 8. Februar 2016, 21:55:12 schrieb Sudeep Holla:
> Keyboard driver for GPIO buttons(gpio-keys) checks for the legacy
> "gpio-key,wakeup" boolean property to enable gpio buttons as wakeup
> source.
> 
> Few dts files assign value "1" to gpio-key,wakeup and in one instance a
> value "0" is assigned probably assuming it won't be enabled as a wakeup
> source. Since the presence of the boolean property indicates it is
> enabled, value of "0" have no value.
> 
> This patch replaces the legacy "gpio-key,wakeup" with the unified
> "wakeup-source" property which inturn fixes the above mentioned issue.
> 
> Cc: linux-rockchip at lists.infradead.org
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm/boot/dts/rk3066a-bqcurie2.dts          | 3 +--
>  arch/arm/boot/dts/rk3066a-rayeager.dts          | 2 +-
>  arch/arm/boot/dts/rk3188-radxarock.dts          | 2 +-
>  arch/arm/boot/dts/rk3288-evb.dtsi               | 2 +-
>  arch/arm/boot/dts/rk3288-firefly.dtsi           | 2 +-
>  arch/arm/boot/dts/rk3288-popmetal.dts           | 2 +-
>  arch/arm/boot/dts/rk3288-r89.dts                | 2 +-
>  arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi | 2 +-
>  arch/arm/boot/dts/rk3288-veyron.dtsi            | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi    | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3368-r88.dts     | 2 +-
>  11 files changed, 11 insertions(+), 12 deletions(-)
> 
> Hi Heiko,
> 
> You can reviewed this, however there are couple of ARM64 dts additions.
> Also most of the other platform/SoC maintainers preferred to take it via
> their tree and few of these got missed during v4.5 merge window.
> Can you take it via your tree for v4.6 ?

I've split the patch in two, as the 32 and 64 bit devicetree parts go 
through separate branches and applied both to their respective branches for 
v4.6


Heiko
