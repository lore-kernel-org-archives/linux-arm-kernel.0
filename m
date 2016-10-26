From: david@lechnology.com (David Lechner)
Date: Wed, 26 Oct 2016 11:08:36 -0500
Subject: [PATCH v6 4/5] ARM: DTS: da850: Add cfgchip syscon node
In-Reply-To: <1477451211-31979-5-git-send-email-david@lechnology.com>
References: <1477451211-31979-1-git-send-email-david@lechnology.com>
 <1477451211-31979-5-git-send-email-david@lechnology.com>
Message-ID: <b9bfc4aa-ef52-53c4-dc7e-c0bc1c5969fb@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2016 10:06 PM, David Lechner wrote:
> Add a syscon node for the SoC CFGCHIPn registers. This is needed for
> the new usb phy driver.
>
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  arch/arm/boot/dts/da850.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index f79e1b9..6bbf20d 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -188,6 +188,10 @@
>  			};
>
>  		};
> +		cfgchip: cfgchip at 1417c {

I wonder if there is a more generic name instead of cfgchip at . Is there a 
preferred generic name for syscon nodes?

> +			compatible = "ti,da830-cfgchip", "syscon";
> +			reg = <0x1417c 0x14>;
> +		};
>  		edma0: edma at 0 {
>  			compatible = "ti,edma3-tpcc";
>  			/* eDMA3 CC0: 0x01c0 0000 - 0x01c0 7fff */
>
