From: klaus.goger@theobroma-systems.com (klaus.goger at theobroma-systems.com)
Date: Fri, 2 Mar 2018 20:49:49 +0100
Subject: [PATCH v2 5/6] arm64: dts: rockchip: enable typec-phy1 for
 rk3399-puma.
In-Reply-To: <20180301152515.20940-6-enric.balletbo@collabora.com>
References: <20180301152515.20940-1-enric.balletbo@collabora.com>
 <20180301152515.20940-6-enric.balletbo@collabora.com>
Message-ID: <056BCD2A-CBAF-46B2-831B-5E60BE4CC74D@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 01.03.2018, at 16:25, Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:
> 
> Commit c301b327aea898af ("arm64: dts: rockchip: add usb3-phy otg-port
> support for rk3399") caused a regression regarding the USB3. During boot,
> the following message appears a few times:
> 
>      dwc3: failed to initialize core
> 
> The driver is deferred waiting for the typec-phy, but this never happens
> beause is disabled. So, enable it.
> 
> Fixes: c301b327aea898af ("arm64: dts: rockchip: add usb3-phy otg-port support for rk3399")
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v2: None
> 
> arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> index 1fc5060d7027..3a3b24383482 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> @@ -505,6 +505,10 @@
> 	};
> };
> 
> +&tcphy1 {
> +	status = "okay";
> +};
> +
> &u2phy1 {
> 	status = "okay";
> 
> -- 
> 2.16.1


Tested-by: Klaus Goger <klaus.goger@theobroma-systems.com>

Looks good. With your patch,the onboard USB hub on tcphy1 is found 
at bootup.

# lsusb  -t
/:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 5000M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 5000M
        |__ Port 2: Dev 3, If 0, Class=Mass Storage, Driver=usb-storage, 5000M
/:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci-hcd/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
        |__ Port 4: Dev 4, If 0, Class=, Driver=, 12M
/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=ohci-platform/1p, 12M
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=ohci-platform/1p, 12M
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=ehci-platform/1p, 480M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=ehci-platform/1p, 480M

? 
Klaus
