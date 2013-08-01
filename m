From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 01 Aug 2013 17:53:35 +1200
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable wireless support
In-Reply-To: <1375287304-3896-1-git-send-email-festevam@gmail.com>
References: <1375287304-3896-1-git-send-email-festevam@gmail.com>
Message-ID: <51F9F7DF.1030205@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/13 04:15, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Wandboard has a Broadcom 4329 chipset connected to SDHC, so turn on the wireless
> related options.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>   arch/arm/configs/imx_v6_v7_defconfig | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index d3e044a..577f054 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -61,7 +61,10 @@ CONFIG_IP_PNP_DHCP=y
>   # CONFIG_INET_LRO is not set
>   CONFIG_IPV6=y
>   CONFIG_NETFILTER=y
> -# CONFIG_WIRELESS is not set
> +CONFIG_CFG80211=y
> +CONFIG_MAC80211=y
> +CONFIG_RFKILL=y
> +CONFIG_RFKILL_INPUT=y
>   CONFIG_DEVTMPFS=y
>   CONFIG_DEVTMPFS_MOUNT=y
>   # CONFIG_STANDALONE is not set
> @@ -115,7 +118,7 @@ CONFIG_SMC91X=y
>   CONFIG_SMC911X=y
>   CONFIG_SMSC911X=y
>   # CONFIG_NET_VENDOR_STMICRO is not set
> -# CONFIG_WLAN is not set
> +CONFIG_BRCMFMAC=m
>   # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
>   CONFIG_INPUT_EVDEV=y
>   CONFIG_INPUT_EVBUG=m
Tested-by: Tony Prisk <linux@prisktech.co.nz>
