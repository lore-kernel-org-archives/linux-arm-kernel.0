From: monstr@monstr.eu (Michal Simek)
Date: Mon, 01 Sep 2014 13:08:40 +0200
Subject: [PATCH v2] ARM: zynq: DT: Add LEDs to zc702 DT
In-Reply-To: <1409323117-21711-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1409323117-21711-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <540453B8.90403@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/29/2014 04:38 PM, Soren Brinkmann wrote:
> From: Ezra Savard <ezra.savard@xilinx.com>
> 
> Adds LEDs to the zc702 devicetree for use with the leds-gpio driver.
> 
> Signed-off-by: Ezra Savard <ezra.savard@xilinx.com>
> Reviewed-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> v2:
>  - fix node names
> ---
>  arch/arm/boot/dts/zynq-zc702.dts | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
> index 835c3089c61c..b29e0f97e764 100644
> --- a/arch/arm/boot/dts/zynq-zc702.dts
> +++ b/arch/arm/boot/dts/zynq-zc702.dts
> @@ -27,6 +27,15 @@
>  		bootargs = "console=ttyPS0,115200 earlyprintk";
>  	};
>  
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		ds23 {
> +			label = "ds23";
> +			gpios = <&gpio0 10 0>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
>  };
>  
>  &can0 {
> 

Applied.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140901/754de40f/attachment.sig>
