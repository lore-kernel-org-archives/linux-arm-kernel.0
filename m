From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 17 May 2015 16:51:46 +0200
Subject: [RFC 2/7] ARM: dts: sun9i: Add CCI-400 device nodes for A80
In-Reply-To: <1431583811-25780-3-git-send-email-wens@csie.org>
References: <1431583811-25780-1-git-send-email-wens@csie.org>
 <1431583811-25780-3-git-send-email-wens@csie.org>
Message-ID: <20150517145146.GK4004@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 02:10:06PM +0800, Chen-Yu Tsai wrote:
> The A80 includes an ARM CCI-400 interconnect to support multi-cluster
> CPU caches.
> 
> Also add the default clock frequency for the CPUs.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun9i-a80.dtsi | 46 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
> index ca272e92b85d..200e712fbf0e 100644
> --- a/arch/arm/boot/dts/sun9i-a80.dtsi
> +++ b/arch/arm/boot/dts/sun9i-a80.dtsi
> @@ -58,48 +58,64 @@
>  		cpu0: cpu at 0 {
>  			compatible = "arm,cortex-a7";
>  			device_type = "cpu";
> +			cci-control-port = <&cci_control0>;
> +			clock-frequency = <12000000>;
>  			reg = <0x0>;
>  		};
>  
>  		cpu1: cpu at 1 {
>  			compatible = "arm,cortex-a7";
>  			device_type = "cpu";
> +			cci-control-port = <&cci_control0>;
> +			clock-frequency = <12000000>;
>  			reg = <0x1>;
>  		};
>  
>  		cpu2: cpu at 2 {
>  			compatible = "arm,cortex-a7";
>  			device_type = "cpu";
> +			cci-control-port = <&cci_control0>;
> +			clock-frequency = <12000000>;
>  			reg = <0x2>;
>  		};
>  
>  		cpu3: cpu at 3 {
>  			compatible = "arm,cortex-a7";
>  			device_type = "cpu";
> +			cci-control-port = <&cci_control0>;
> +			clock-frequency = <12000000>;
>  			reg = <0x3>;
>  		};
>  
>  		cpu4: cpu at 100 {
>  			compatible = "arm,cortex-a15";
>  			device_type = "cpu";
> +			cci-control-port = <&cci_control1>;
> +			clock-frequency = <9000000>;

Isn't the clock frequency property is supposed to be the maximum
frequency of that CPU in Linux?

It looks odd that the A15 are clocked at a lower frequency than the
A7...

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150517/155dd034/attachment.sig>
