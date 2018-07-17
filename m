From: monstr@monstr.eu (Michal Simek)
Date: Tue, 17 Jul 2018 16:40:22 +0200
Subject: [PATCH] arm64: zynqmp: Use serdev for zcu100 BT
In-Reply-To: <0ce3b4f588f1d9a83cfe99b93af3514f4d893273.1523452571.git.michal.simek@xilinx.com>
References: <0ce3b4f588f1d9a83cfe99b93af3514f4d893273.1523452571.git.michal.simek@xilinx.com>
Message-ID: <9e8bdff9-8239-56ea-8ede-472bb47baacd@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11.4.2018 15:16, Michal Simek wrote:
> Mainline started to use serdev interface for uart attached devices.
> Change description to reflect it.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> index 3e862a9faf26..c7f713c8e69e 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> @@ -89,12 +89,6 @@
>  			gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
>  			default-state = "on";
>  		};
> -
> -		bt_power {
> -			label = "bt_power";
> -			gpios = <&gpio 8 GPIO_ACTIVE_HIGH>;
> -			default-state = "on";
> -		};
>  	};
>  
>  	wmmcsdio_fixed: fixedregulator-mmcsdio {
> @@ -267,6 +261,10 @@
>  
>  &uart0 {
>  	status = "okay";
> +	bluetooth {
> +		compatible = "ti,wl1831-st";
> +		enable-gpios = <&gpio 8 GPIO_ACTIVE_HIGH>;
> +	};
>  };
>  
>  &uart1 {
> 

Applied.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180717/c5fcc39b/attachment.sig>
