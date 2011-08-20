From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 20 Aug 2011 17:51:37 +0800
Subject: [PATCH 1/6] ARM: highbank: add devicetree source
In-Reply-To: <1313526898-19920-2-git-send-email-robherring2@gmail.com>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<1313526898-19920-2-git-send-email-robherring2@gmail.com>
Message-ID: <20110820095136.GA13302@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2011 at 03:34:53PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This adds the devicetree source and documentation for the Calxeda highbank
> platform.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> ---
>  Documentation/devicetree/bindings/arm/calxeda.txt |    8 +
>  arch/arm/boot/dts/highbank.dts                    |  212 +++++++++++++++++++++
>  2 files changed, 220 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/calxeda.txt
>  create mode 100644 arch/arm/boot/dts/highbank.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/calxeda.txt b/Documentation/devicetree/bindings/arm/calxeda.txt
> new file mode 100644
> index 0000000..4755caa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/calxeda.txt
> @@ -0,0 +1,8 @@
> +Calxeda Highbank Platforms Device Tree Bindings
> +-----------------------------------------------
> +
> +Boards with Calxeda Cortex-A9 based Highbank SOC shall have the following
> +properties.
> +
> +Required root node properties:
> +    - compatible = "calxeda,highbank";
> diff --git a/arch/arm/boot/dts/highbank.dts b/arch/arm/boot/dts/highbank.dts
> new file mode 100644
> index 0000000..2dd3b7b
> --- /dev/null
> +++ b/arch/arm/boot/dts/highbank.dts
> @@ -0,0 +1,212 @@
> +/*
> + * Copyright 2011 Calxeda, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License along with
> + * this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +/dts-v1/;
> +
> +/* First 4KB has pen for secondary cores. */
> +/memreserve/ 0x00000000 0x0001000;
> +
> +/ {
> +	model = "Calxeda Highbank";
> +	compatible = "calxeda,highbank";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu at 0 {
> +			compatible = "arm,cortex-a9";
> +			reg = <0>;
> +			next-level-cache = <&L2>;
> +		};
> +
> +		cpu at 1 {
> +			compatible = "arm,cortex-a9";
> +			reg = <1>;
> +			next-level-cache = <&L2>;
> +		};
> +
> +		cpu at 2 {
> +			compatible = "arm,cortex-a9";
> +			reg = <2>;
> +			next-level-cache = <&L2>;
> +		};
> +
> +		cpu at 3 {
> +			compatible = "arm,cortex-a9";
> +			reg = <3>;
> +			next-level-cache = <&L2>;
> +		};
> +	};
> +
I'm not sure if this whole "cpus" stuff is needed, I do not see any
code playing with it.

-- 
Regards,
Shawn
