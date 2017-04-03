From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Apr 2017 13:19:54 +0200
Subject: [PATCH v3 04/20] ARM: sun8i: dt: Add DT bindings documentation
 for Allwinner syscon
In-Reply-To: <20170403091444.29876-5-clabbe.montjoie@gmail.com>
References: <20170403091444.29876-1-clabbe.montjoie@gmail.com>
 <20170403091444.29876-5-clabbe.montjoie@gmail.com>
Message-ID: <20170403111954.tolvlw7klswaxkl4@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 03, 2017 at 11:14:28AM +0200, Corentin Labbe wrote:
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  .../devicetree/bindings/misc/allwinner,syscon.txt     | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/allwinner,syscon.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/allwinner,syscon.txt b/Documentation/devicetree/bindings/misc/allwinner,syscon.txt
> new file mode 100644
> index 0000000..9f5f1f5
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
> +		"allwinner,sun8i-a83t-system-controller"
> +
> +Example:
> +syscon: syscon at 01c00000 {
> +	compatible = "syscon", "allwinner,sun8i-h3-system-controller";

The syntax is the more specific first, so your compatibles should be
the other way around.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170403/e7c8e1d7/attachment.sig>
