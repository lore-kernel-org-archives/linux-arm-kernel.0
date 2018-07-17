From: monstr@monstr.eu (Michal Simek)
Date: Tue, 17 Jul 2018 16:42:05 +0200
Subject: [PATCH] arm64: zynqmp: Remove #address/#size-cells from gpio-keys
In-Reply-To: <cc96e8372881438fb069d49126ab713fa03fb074.1525260692.git.michal.simek@xilinx.com>
References: <cc96e8372881438fb069d49126ab713fa03fb074.1525260692.git.michal.simek@xilinx.com>
Message-ID: <50a270ad-93e6-5be2-ab57-bd4cbd9fe49a@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2.5.2018 13:34, Michal Simek wrote:
> dts reports incorrect usage of these properties in gpio-keys node.
> Warning (avoid_unnecessary_addr_size): /gpio-keys: unnecessary
> 
> The patch is removing these useless properties.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 2 --
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 2 --
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts | 2 --
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 2 --
>  4 files changed, 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> index c7f713c8e69e..eb5e8bddb610 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> @@ -44,8 +44,6 @@
>  
>  	gpio-keys {
>  		compatible = "gpio-keys";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>  		autorepeat;
>  		sw4 {
>  			label = "sw4";
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> index 5b4ffe646a9b..25dd57485323 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> @@ -41,8 +41,6 @@
>  
>  	gpio-keys {
>  		compatible = "gpio-keys";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>  		autorepeat;
>  		sw19 {
>  			label = "sw19";
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> index 668f7f26716a..259f21b0c001 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> @@ -41,8 +41,6 @@
>  
>  	gpio-keys {
>  		compatible = "gpio-keys";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>  		autorepeat;
>  		sw19 {
>  			label = "sw19";
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> index 9a9dd6a0142b..a61b3cc6f4c9 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> @@ -41,8 +41,6 @@
>  
>  	gpio-keys {
>  		compatible = "gpio-keys";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>  		autorepeat;
>  		sw19 {
>  			label = "sw19";
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180717/f987a6e3/attachment-0001.sig>
