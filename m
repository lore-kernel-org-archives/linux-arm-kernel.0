From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 03 Jun 2016 00:47:03 +0300
Subject: [PATCH/RFC v3 01/22] reset: Add renesas,rst DT bindings
In-Reply-To: <1464808880-343-2-git-send-email-geert+renesas@glider.be>
References: <1464808880-343-1-git-send-email-geert+renesas@glider.be>
 <1464808880-343-2-git-send-email-geert+renesas@glider.be>
Message-ID: <10393056.BKo7UTPXFi@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Thank you for the patch.

On Wednesday 01 Jun 2016 21:20:59 Geert Uytterhoeven wrote:
> Add DT bindings for the Renesas R-Car Reset Controller (R-Car Gen1
> RESET/WDT and R-Car Gen2/Gen3 RST).
> 
> As the features provided by the hardware module differ a lot across the
> various SoC families and members, only SoC-specific compatible values
> are defined.
> 
> For now we use the RST only for providing access to the state of the
> mode pins.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Magnus Damm <damm+renesas@opensource.se>
> ---
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
>  .../devicetree/bindings/reset/renesas,rst.txt      | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/renesas,rst.txt
> 
> diff --git a/Documentation/devicetree/bindings/reset/renesas,rst.txt
> b/Documentation/devicetree/bindings/reset/renesas,rst.txt new file mode
> 100644
> index 0000000000000000..488c72e1ee849cd3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/renesas,rst.txt
> @@ -0,0 +1,35 @@
> +DT bindings for the Renesas R-Car Reset Controller
> +
> +The R-Car Reset Controller provides reset control, and implements the
> following
> +functions:
> +  - Latching of the levels on mode pins when PRESET# is negated,
> +  - Mode monitoring register,
> +  - Reset control of peripheral devices (on R-Car Gen1),
> +  - Watchdog timer (on R-Car Gen1).
> +  - Register-based reset control and boot address registers for the various
> CPU
> +    cores (on R-Car Gen2/Gen3),
> +
> +
> +Required properties:
> +  - compatible: Should be
> +		  - "renesas,<soctype>-reset-wdt" for R-Car Gen1,
> +		  - "renesas,<soctype>-rst" for R-Car Gen2/Gen3.
> +		Examples with soctypes are:
> +		  - "renesas,r8a7778-reset-wdt" (R-Car M1A)
> +		  - "renesas,r8a7779-reset-wdt" (R-Car H1)
> +		  - "renesas,r8a7790-rst" (R-Car H2)
> +		  - "renesas,r8a7791-rst" (R-Car M2-W)
> +		  - "renesas,r8a7792-rst" (R-Car V2H
> +		  - "renesas,r8a7793-rst" (R-Car M2-N)
> +		  - "renesas,r8a7794-rst" (R-Car E2)
> +		  - "renesas,r8a7795-rst" (R-Car H3)
> +		  - "renesas,r8a7796-rst" (R-Car M3-W)

Any specific reason for such a large indentation ? (I know this is really 
nitpicking)

Apart from that, it's just a bit of a shame we can't have generic compatible 
strings, but that would require additional DT properties to describe the reset 
controller features, and I assume that's not a path we want to take.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +  - reg: Address start and address range for the device.
> +
> +
> +Example:
> +
> +	rst: reset-controller at e6160000 {
> +		compatible = "renesas,r8a7795-rst";
> +		reg = <0 0xe6160000 0 0x0200>;
> +	};

-- 
Regards,

Laurent Pinchart
