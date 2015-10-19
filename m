From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Oct 2015 09:06:07 -0700
Subject: [PATCH v2 2/3] ARM: dts: AM43x-epos-evm: Add AM438x compatible
 string for epos
In-Reply-To: <1444885808-6306-3-git-send-email-j-keerthy@ti.com>
References: <1444885808-6306-1-git-send-email-j-keerthy@ti.com>
 <1444885808-6306-3-git-send-email-j-keerthy@ti.com>
Message-ID: <20151019160606.GC22043@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Keerthy <j-keerthy@ti.com> [151014 22:14]:
> Add AM438x compatible property to identify the SoCs on epos evms.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Changes in v2:
> 
>   * Rebased to latest 4.3-rc5
> 
>  Documentation/devicetree/bindings/arm/omap/omap.txt | 5 ++++-
>  arch/arm/boot/dts/am43x-epos-evm.dts                | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Documentation/devicetree/bindings/arm/omap/omap.txt
> index 9f4e513..dc3b5f2 100644
> --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> @@ -100,6 +100,9 @@ SoCs:
>  - AM4372
>    compatible = "ti,am4372", "ti,am43"
>  
> +- AM438x
> +  compatible = "ti,am438x", "ti,am43"
> +

The compatible strings should not have x, this should be
"ti,am438" instead. But my guess is that we are better off
adding proper SoC detection to avoid needing a separate dts
file for each SoC revision. Ideally booting with "ti,am43"
should be enough and we can initialize the rest during
runtime.

Regards,

Tony
