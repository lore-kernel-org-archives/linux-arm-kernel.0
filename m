From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sat, 26 Jan 2013 23:47:11 +0400
Subject: [PATCH v2 4/6] ARM: dts: omap5: add dwc3 omap dt data
In-Reply-To: <1359112312-6918-5-git-send-email-kishon@ti.com>
References: <1359112312-6918-1-git-send-email-kishon@ti.com>
 <1359112312-6918-5-git-send-email-kishon@ti.com>
Message-ID: <510432BF.80808@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 25-01-2013 15:11, Kishon Vijay Abraham I wrote:

> Add dwc3 omap glue data to the omap5 dt data file. The information about
> the dt node added here is available @
> Documentation/devicetree/bindings/usb/omap-usb.txt

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>   arch/arm/boot/dts/omap5.dtsi |   11 +++++++++++
>   1 file changed, 11 insertions(+)

> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 5f59bf2..1703a72 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -513,6 +513,17 @@
>   			ti,type = <2>;
>   		};
>
> +		omap_dwc3 at 4a020000 {
> +			compatible = "ti,dwc3";
> +			ti,hwmods = "usb_otg_ss";
> +			reg = <0x4a020000 0x1ff>;

    Shoudn't the "reg" length be 0x200 here? It's length, not limit.

WBR, Sergei
