From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 25 Sep 2014 15:33:29 +0200
Subject: [PATCH v2 3/7] ARM: dts: sunxi: Add Allwinner A80 dtsi
In-Reply-To: <1411570141-29960-4-git-send-email-wens@csie.org>
References: <1411570141-29960-1-git-send-email-wens@csie.org>
 <1411570141-29960-4-git-send-email-wens@csie.org>
Message-ID: <20140925133329.GH15315@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 10:48:57PM +0800, Chen-Yu Tsai wrote:
> The Allwinner A80 is a new multi-purpose SoC with 4 Cortex-A7 and
> 4 Cortex-A15 cores in a big.LITTLE architecture, and a 64-core
> PowerVR G6230 GPU.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun9i-a80.dtsi | 287 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 287 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun9i-a80.dtsi
> 
> diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
> new file mode 100644
> index 0000000..34a0068
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun9i-a80.dtsi
> @@ -0,0 +1,287 @@
> +/*
> + * Copyright 2014 Chen-Yu Tsai
> + *
> + * Chen-Yu Tsai <wens@csie.org>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + *     You should have received a copy of the GNU General Public
> + *     License along with this library; if not, write to the Free
> + *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
> + *     MA 02110-1301 USA
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/include/ "skeleton64.dtsi"
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +		serial4 = &uart4;
> +		serial5 = &uart5;
> +		serial6 = &r_uart;
> +	};
> +
> +	cpu-map {
> +		cluster0 {
> +			core0 {
> +				cpu = <&cpu0>;
> +			};
> +
> +			core1 {
> +				cpu = <&cpu1>;
> +			};
> +
> +			core2 {
> +				cpu = <&cpu2>;
> +			};
> +
> +			core3 {
> +				cpu = <&cpu3>;
> +			};
> +		};
> +
> +		cluster1 {
> +			core0 {
> +				cpu = <&cpu4>;
> +			};
> +
> +			core1 {
> +				cpu = <&cpu5>;
> +			};
> +
> +			core2 {
> +				cpu = <&cpu6>;
> +			};
> +
> +			core3 {
> +				cpu = <&cpu7>;
> +			};
> +		};
> +	};

Like you already found out, the topology code doesn't use the cpu-map
but only relies on the cpu compatible and max frequencies, so you can
drop this.

> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu at 0 {
> +			compatible = "arm,cortex-a7";
> +			device_type = "cpu";
> +			reg = <0x0>;
> +		};
> +
> +		cpu1: cpu at 1 {
> +			compatible = "arm,cortex-a7";
> +			device_type = "cpu";
> +			reg = <0x1>;
> +		};
> +
> +		cpu2: cpu at 2 {
> +			compatible = "arm,cortex-a7";
> +			device_type = "cpu";
> +			reg = <0x2>;
> +		};
> +
> +		cpu3: cpu at 3 {
> +			compatible = "arm,cortex-a7";
> +			device_type = "cpu";
> +			reg = <0x3>;
> +		};
> +
> +		cpu4: cpu at 100 {
> +			compatible = "arm,cortex-a15";
> +			device_type = "cpu";
> +			reg = <0x100>;
> +		};
> +
> +		cpu5: cpu at 101 {
> +			compatible = "arm,cortex-a15";
> +			device_type = "cpu";
> +			reg = <0x101>;
> +		};
> +
> +		cpu6: cpu at 102 {
> +			compatible = "arm,cortex-a15";
> +			device_type = "cpu";
> +			reg = <0x102>;
> +		};
> +
> +		cpu7: cpu at 103 {
> +			compatible = "arm,cortex-a15";
> +			device_type = "cpu";
> +			reg = <0x103>;
> +		};
> +	};
> +
> +	memory {
> +		/* 8GB max. with LPAE */
> +		reg = <0 0x20000000 0x02 0>;
> +	};
> +
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0 0x20000000>;

A comment for this ranges would be nice.

I looks fine otherwise.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140925/30b85d76/attachment-0001.sig>
