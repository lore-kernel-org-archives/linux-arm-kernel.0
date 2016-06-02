From: robh@kernel.org (Rob Herring)
Date: Thu, 2 Jun 2016 12:14:22 -0500
Subject: [PATCH v5 2/3] documentation: Add secure monitor binding
 documentation
In-Reply-To: <1464520323-19531-3-git-send-email-carlo@caione.org>
References: <1464520323-19531-1-git-send-email-carlo@caione.org>
 <1464520323-19531-3-git-send-email-carlo@caione.org>
Message-ID: <20160602171422.GA17166@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 29, 2016 at 01:12:02PM +0200, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> Add the binding documentation for the Amlogic secure monitor driver.
> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>  .../bindings/firmware/meson/meson_sm.txt           | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/meson/meson_sm.txt
> 
> diff --git a/Documentation/devicetree/bindings/firmware/meson/meson_sm.txt b/Documentation/devicetree/bindings/firmware/meson/meson_sm.txt
> new file mode 100644
> index 0000000..6f0b5bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/meson/meson_sm.txt
> @@ -0,0 +1,33 @@
> +* Amlogic Secure Monitor
> +
> +In the Amlogic SoCs the Secure Monitor code is used to provide access to the
> +NVMEM, enable JTAG, set USB boot, etc...
> +
> +Required properties for the secure monitor node:
> +- compatible: Should be "amlogic,meson-gxbb-sm"
> +
> +Example:
> +
> +	firmware {
> +		compatible = "simple-bus";

Drop this. Sorry, but no abusing simple-bus to get automagic creation of 
your platform device.

> +
> +		sm: secure-monitor {
> +			compatible = "amlogic,meson-gxbb-sm";
> +		};
> +	};
> +
> +Example of the node using the secure monitor:
> +
> +	#include <dt-bindings/firmware/meson-sm.h>
> +
> +	...
> +
> +	efuse: efuse {
> +		compatible = "amlogic,meson-gxbb-efuse";
> +		secure-monitor = <&sm>;

Why do you need this? Given there can only be one node, just use 
of_find_compatible_node();

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		...
> +	};
> +
> -- 
> 2.7.4
> 
