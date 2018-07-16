From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 16 Jul 2018 19:02:24 +0200
Subject: [PATCH v2] arm64: dts: rockchip: add USB 2.0 and 3.0 support on
 Ficus board
In-Reply-To: <20180714170922.4433-1-ezequiel@collabora.com>
References: <20180714170922.4433-1-ezequiel@collabora.com>
Message-ID: <2487041.HPaZN1uVBU@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Enric, Ezequiel,

Am Samstag, 14. Juli 2018, 19:09:22 CEST schrieb Ezequiel Garcia:
> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> The board exposes two types A ports, one is USB 3.0, up to 5.0Gbps and
> another one is USB 2.0 up to 480Mbps. Enable the USB PHYs and the USB
> controllers to enable theses devices.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
> Changes from v1:
>  * Provide voltage for vcc5v0_host and vcc3v3_pcie regulators
>  * Provide vin_supply for vcc5v0_host.
> 
>  arch/arm64/boot/dts/rockchip/rk3399-ficus.dts | 90 +++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> index 0d14183dd4a9..6295483b701f 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> @@ -58,9 +58,24 @@
>  		pinctrl-0 = <&pcie_drv>;
>  		regulator-boot-on;
>  		regulator-name = "vcc3v3_pcie";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
>  		vin-supply = <&vcc3v3_sys>;
>  	};

I've split this out into a separate patch, as it isn't part of what
the commit message describes and thus should be separate
and applied both resulting patches for 4.19.

And also cleaned up a vendor-property that shouldn't be
part of mainline.


Heiko
