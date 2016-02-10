From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Feb 2016 15:38:48 +0100
Subject: [PATCH 4/8] arm: dts: add Artpec-6 soc dtsi file
In-Reply-To: <733065957e9ec67d698870cf832b4641d0da30cb.1455107681.git.larper@axis.com>
References: <cover.1455107681.git.larper@axis.com>
 <733065957e9ec67d698870cf832b4641d0da30cb.1455107681.git.larper@axis.com>
Message-ID: <2518578.qKxQQXPlfn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 February 2016 13:41:53 Lars Persson wrote:
> Signed-off-by: Lars Persson <larper@axis.com>
> ---

Missing changelog

>  arch/arm/boot/dts/artpec6.dtsi | 238 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 238 insertions(+)
>  create mode 100644 arch/arm/boot/dts/artpec6.dtsi
> 
> diff --git a/arch/arm/boot/dts/artpec6.dtsi b/arch/arm/boot/dts/artpec6.dtsi
> new file mode 100644
> index 0000000..c1790d8
> --- /dev/null
> +++ b/arch/arm/boot/dts/artpec6.dtsi
> @@ -0,0 +1,238 @@
> +/*
> + * Device Tree Source for the Axis ARTPEC-6 SoC
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include "skeleton.dtsi"
> +
> +/ {
> +	compatible = "axis,artpec6";
> +	interrupt-parent = <&intc>;
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +	};

Move the aliases into the board, not all boards might use all four
uarts, or some board might assign different numbers.

> +		uart0: uart at f8036000 {

make this "serial at f8036000"

	Arnd
