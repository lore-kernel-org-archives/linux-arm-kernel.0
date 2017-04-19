From: andre.przywara@arm.com (=?UTF-8?Q?Andr=c3=a9_Przywara?=)
Date: Thu, 20 Apr 2017 00:38:50 +0100
Subject: [PATCH v4 04/18] dt-bindings: syscon: Add DT bindings
 documentation for Allwinner syscon
In-Reply-To: <20170412111400.2296-5-clabbe.montjoie@gmail.com>
References: <20170412111400.2296-1-clabbe.montjoie@gmail.com>
 <20170412111400.2296-5-clabbe.montjoie@gmail.com>
Message-ID: <9382f9ae-895a-397b-3d8c-846cb0bc4486@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/04/17 12:13, Corentin Labbe wrote:
> This patch adds documentation for Device-Tree bindings for the
> syscon present in allwinner devices.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  .../devicetree/bindings/misc/allwinner,syscon.txt     | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/allwinner,syscon.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/allwinner,syscon.txt b/Documentation/devicetree/bindings/misc/allwinner,syscon.txt
> new file mode 100644
> index 0000000..c056c5b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/allwinner,syscon.txt
> @@ -0,0 +1,19 @@
> +* Allwinner sun8i system controller
> +
> +This file describes the bindings for the system controller present in
> +Allwinner SoC H3, A83T and A64.
> +The principal function of this syscon is to control EMAC PHY choice and
> +config.
> +
> +Required properties for the system controller:
> +- reg: address and length of the register for the device.
> +- compatible: should be "syscon" and one of the following string:
> +		"allwinner,sun8i-h3-system-controller"
> +		"allwinner,sun8i-a64-system-controller"

While sun8i might make some sense technically, all 64-bit sunxi
compatible strings use the sun50i prefix to follow the Allwinner naming.
So this should read:
		"allwinner,sun50i-a64-system-controller"

Also I am wondering if we should add a compatible string for the H5
(support for that SoC is in -next already):
		"allwinner,sun50i-h5-system-controller"

Cheers,
Andre.

> +		"allwinner,sun8i-a83t-system-controller"
> +
> +Example:
> +syscon: syscon at 01c00000 {
> +	compatible = "allwinner,sun8i-h3-system-controller", "syscon";
> +	reg = <0x01c00000 0x1000>;
> +};
> 
