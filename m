From: valentin.schneider@arm.com (Valentin Schneider)
Date: Wed, 13 Jun 2018 22:47:54 +0100
Subject: [PATCH] arm64: dts: hikey960: Define wl1837 power capabilities
In-Reply-To: <20180613180321.16745-1-ryan@edited.us>
References: <20180613180321.16745-1-ryan@edited.us>
Message-ID: <91404bb0-4fa8-4e00-0b21-c104a5171833@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/06/18 19:03, Ryan Grachek wrote:
> These properties are required for compatibility with runtime PM.
> Without these properties, MMC host controller will not be aware
> of power capabilities. When the wlcore driver attempts to power
> on the device, it will erroneously fail with -EACCES. This fixes
> a regression found here: https://lkml.org/lkml/2018/6/12/930
> 

Thanks! As mentioned in the above thread, this lets wlan0 come up properly,
which otherwise doesn't come up and spits out:
[    8.466097] wl1271_sdio mmc1:0001:2: wl12xx_sdio_power_on: failed to get_sync(-13)

Tested-by: Valentin Schneider <valentin.schneider@arm.com>

> Signed-off-by: Ryan Grachek <ryan@edited.us>
> ---
>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> index c6999624ed8a..68c5a6c819ae 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -585,6 +585,8 @@
>  	vmmc-supply = <&wlan_en>;
>  	ti,non-removable;
>  	non-removable;
> +	cap-power-off-card;
> +	keep-power-in-suspend;
>  	#address-cells = <0x1>;
>  	#size-cells = <0x0>;
>  	status = "ok";
> 
