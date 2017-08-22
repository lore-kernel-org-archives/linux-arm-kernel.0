From: tony@atomide.com (Tony Lindgren)
Date: Tue, 22 Aug 2017 10:39:30 -0700
Subject: [PATCH v2 3/5] dt-bindings: sdhci-omap: Add bindings for the
 sdhci-omap controller
In-Reply-To: <20170822133907.21549-1-kishon@ti.com>
References: <20170821142132.GH6008@atomide.com>
 <20170822133907.21549-1-kishon@ti.com>
Message-ID: <20170822173929.GL6008@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [170822 06:39]:
> Add binding for the TI's sdhci-omap controller. This now includes only
> a subset of properties documented in ti-omap-hsmmc.txt but will eventually
> include all the properties.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> Changes from v1:
> *) Create a new sdhci-omap.txt document for TI's sdhci-omap controller instead
>    of using the ti-omap-hsmmc.txt as suggested by Tony

Works for me thanks, just one typo below..

>  .../devicetree/bindings/mmc/sdhci-omap.txt         | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> new file mode 100644
> index 000000000000..139695ad2d58
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> @@ -0,0 +1,22 @@
> +* TI OMAP SDHCI Controller
> +
> +Refer to mmc.txt for standard MMC bindings.
> +
> +Required properties:
> +- compatible: Should be "ti,dra7-sdhci" for DRA7 and DRA72 controllers
> +- ti,hwmods: Must be "mmc<n>", <n> is controller instance starting 1
> +
> +Optional properties:
> +- ti,dual-volt: boolean, supports dual voltage cards
> +- ti,non-removable: non-removable slot (like eMMC)
> +
> +Example:
> +	mmc1: mmc at 0x4809c000 {
> +		compatible = "ti,omap4-hsmmc";

The compatible in the example here is still using hsmmc :)

Tony
