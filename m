From: horms@verge.net.au (Simon Horman)
Date: Tue, 2 Apr 2013 10:13:30 +0900
Subject: [PATCH] ARM: shmobile: r8a73a4 SoC 64-bit DT support
In-Reply-To: <20130329074556.15428.88694.sendpatchset@w520>
References: <20130329074556.15428.88694.sendpatchset@w520>
Message-ID: <20130402011329.GA19813@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 29, 2013 at 04:45:56PM +0900, Magnus Damm wrote:
> From: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
> 
> The r8a73a4 SoC supports LPAE and has memory window up to
> 0x2ffffffff. Convert to 64-bit addresses by enlarging
> #addr-cells and #size-cells to 2.
> 
> Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, queued up for v3.10 in the soc branch.

> ---
> 
>  Depends on the following series:
>  [PATCH 00/04] ARM: shmobile: r8a73a4 SoC support V3
> 
>  arch/arm/boot/dts/r8a73a4.dtsi |   20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> --- 0001/arch/arm/boot/dts/r8a73a4.dtsi
> +++ work/arch/arm/boot/dts/r8a73a4.dtsi	2013-03-29 16:02:06.000000000 +0900
> @@ -9,11 +9,11 @@
>   * kind, whether express or implied.
>   */
>  
> -/include/ "skeleton.dtsi"
> -
>  / {
>  	compatible = "renesas,r8a73a4";
>  	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
>  
>  	cpus {
>  		#address-cells = <1>;
> @@ -32,10 +32,10 @@
>  		#interrupt-cells = <3>;
>  		#address-cells = <0>;
>  		interrupt-controller;
> -		reg = <0xf1001000 0x1000>,
> -			<0xf1002000 0x1000>,
> -			<0xf1004000 0x2000>,
> -			<0xf1006000 0x2000>;
> +		reg = <0 0xf1001000 0 0x1000>,
> +			<0 0xf1002000 0 0x1000>,
> +			<0 0xf1004000 0 0x2000>,
> +			<0 0xf1006000 0 0x2000>;
>  		interrupts = <1 9 0xf04>;
>  
>  		gic-cpuif at 4 {
> @@ -57,7 +57,7 @@
>  		compatible = "renesas,irqc";
>  		#interrupt-cells = <2>;
>  		interrupt-controller;
> -		reg = <0xe61c0000 0x200>;
> +		reg = <0 0xe61c0000 0 0x200>;
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 0 4>, <0 1 4>, <0 2 4>,	<0 3 4>,
>  				<0 4 4>, <0 5 4>, <0 6 4>, <0 7 4>,
> @@ -73,7 +73,7 @@
>  		compatible = "renesas,irqc";
>  		#interrupt-cells = <2>;
>  		interrupt-controller;
> -		reg = <0xe61c0200 0x200>;
> +		reg = <0 0xe61c0200 0 0x200>;
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 32 4>, <0 33 4>, <0 34 4>, <0 35 4>,
>  				<0 36 4>, <0 37 4>, <0 38 4>, <0 39 4>,
> @@ -86,8 +86,8 @@
>  
>  	thermal at e61f0000 {
>  		compatible = "renesas,rcar-thermal";
> -		reg = <0xe61f0000 0x14>, <0xe61f0100 0x38>,
> -			 <0xe61f0200 0x38>, <0xe61f0300 0x38>;
> +		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>,
> +			 <0 0xe61f0200 0 0x38>, <0 0xe61f0300 0 0x38>;
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 69 4>;
>  	};
> 
