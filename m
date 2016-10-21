From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 21 Oct 2016 17:48:40 +0200
Subject: [PATCH v4 01/23] reset: Add renesas,rst DT bindings
In-Reply-To: <1477055857-17936-2-git-send-email-geert+renesas@glider.be>
References: <1477055857-17936-1-git-send-email-geert+renesas@glider.be>
 <1477055857-17936-2-git-send-email-geert+renesas@glider.be>
Message-ID: <1477064920.2508.27.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 21.10.2016, 15:17 +0200 schrieb Geert Uytterhoeven:
> Add DT bindings for the Renesas R-Car Reset Controller (R-Car Gen1
> RESET/WDT and R-Car Gen2/Gen3 and RZ/G RST).
> 
> As the features provided by the hardware module differ a lot across the
> various SoC families and members, only SoC-specific compatible values
> are defined.
> 
> For now we use the RST only for providing access to the state of the
> mode pins, which is needed by the clock driver.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Magnus Damm <damm+renesas@opensource.se>
> Acked-by: Dirk Behme <dirk.behme@de.bosch.com>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> v4:
>   - Add Acked-by,
>   - Fix comma and period in list,
>   - Add RZ/G1M and RZ/G1E,
> 
> v3:
>   - Clarify current usage,
>   - Use "renesas,<soctype>-rst" instead of "renesas,rst-<soctype>",
>   - Drop "syscon" compatible value,
>   - Add R-Car M3-W,
>   - Add R-Car Gen1,
> 
> v2:
>   - Add Acked-by.
> ---
>  .../devicetree/bindings/reset/renesas,rst.txt      | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/renesas,rst.txt
> 
> diff --git a/Documentation/devicetree/bindings/reset/renesas,rst.txt b/Documentation/devicetree/bindings/reset/renesas,rst.txt
> new file mode 100644
> index 0000000000000000..fe5e0f37b3c93579
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/renesas,rst.txt
> @@ -0,0 +1,37 @@
> +DT bindings for the Renesas R-Car and RZ/G Reset Controllers
> +
> +The R-Car and RZ/G Reset Controllers provide reset control, and implement the
> +following functions:
> +  - Latching of the levels on mode pins when PRESET# is negated,
> +  - Mode monitoring register,
> +  - Reset control of peripheral devices (on R-Car Gen1),
> +  - Watchdog timer (on R-Car Gen1),
> +  - Register-based reset control and boot address registers for the various CPU
> +    cores (on R-Car Gen2 and Gen3, and on RZ/G).
> +
> +
> +Required properties:
> +  - compatible: Should be
> +		  - "renesas,<soctype>-reset-wdt" for R-Car Gen1,
> +		  - "renesas,<soctype>-rst" for R-Car Gen2 and Gen3, and RZ/G
> +		Examples with soctypes are:
> +		  - "renesas,r8a7743-rst" (RZ/G1M)
> +		  - "renesas,r8a7745-rst" (RZ/G1E)
> +		  - "renesas,r8a7778-reset-wdt" (R-Car M1A)
> +		  - "renesas,r8a7779-reset-wdt" (R-Car H1)
> +		  - "renesas,r8a7790-rst" (R-Car H2)
> +		  - "renesas,r8a7791-rst" (R-Car M2-W)
> +		  - "renesas,r8a7792-rst" (R-Car V2H
> +		  - "renesas,r8a7793-rst" (R-Car M2-N)
> +		  - "renesas,r8a7794-rst" (R-Car E2)
> +		  - "renesas,r8a7795-rst" (R-Car H3)
> +		  - "renesas,r8a7796-rst" (R-Car M3-W)
> +  - reg: Address start and address range for the device.
> +
> +
> +Example:
> +
> +	rst: reset-controller at e6160000 {
> +		compatible = "renesas,r8a7795-rst";
> +		reg = <0 0xe6160000 0 0x0200>;
> +	};


Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
