From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 11 May 2015 21:37:05 +0900
Subject: [PATCH] ARM: exynos_defconfig: add options to make wifi usable
In-Reply-To: <20150511105034.40580.qmail@dec59.ruk.cuni.cz>
References: <20150511105034.40580.qmail@dec59.ruk.cuni.cz>
Message-ID: <CAJKOXPdj9QH13nD14wQUZBt8iGRmrAWEgHH4LNjz11+b8Ydu1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-11 19:22 GMT+09:00 Michal Suchanek <hramrach@gmail.com>:
>
> The Exynos defconfig includes mwifiex sdio support which is present on
> some of the Exynos boards.
>
> For the WiFi to be usable two extra options are needed. Usermode
> firmware helper to load out-of-kernel firmware and wireless extensions
> so the interface can be configured with wireless-tools.
>
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
> ---
>  arch/arm/configs/exynos_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index d034c96..5d4ee83f 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -42,6 +42,7 @@ CONFIG_IP_PNP_BOOTP=y
>  CONFIG_IP_PNP_RARP=y
>  CONFIG_WIRELESS=y
>  CONFIG_CFG80211=y
> +CONFIG_CFG80211_WEXT=y

Hi,

No, the CFG80211_WEXT is the old interface. I think there were some
plans to mark it deprecated. Anyway it should not be enabled by
default and almost none of configs enable it.

>  CONFIG_MWIFIEX=y
>  CONFIG_MWIFIEX_SDIO=y
>  CONFIG_RFKILL_REGULATOR=y
> @@ -49,6 +50,7 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_PROC_DEVICETREE=y
> +CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y

It is an fallback, not usual way of loading firmware. In typical cases
this should not be needed. Why Exynos defconfig should be exceptional
here?

Best regards,
Krzysztof
