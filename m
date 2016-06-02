From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Thu, 2 Jun 2016 07:40:05 +0200
Subject: [PATCH/RFC v3 01/22] reset: Add renesas,rst DT bindings
In-Reply-To: <1464808880-343-2-git-send-email-geert+renesas@glider.be>
References: <1464808880-343-1-git-send-email-geert+renesas@glider.be>
 <1464808880-343-2-git-send-email-geert+renesas@glider.be>
Message-ID: <64a3f52f-0107-2592-3129-c4a40f830829@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.06.2016 21:20, Geert Uytterhoeven wrote:
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
>  .../devicetree/bindings/reset/renesas,rst.txt      | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/renesas,rst.txt
>
> diff --git a/Documentation/devicetree/bindings/reset/renesas,rst.txt b/Documentation/devicetree/bindings/reset/renesas,rst.txt
> new file mode 100644
> index 0000000000000000..488c72e1ee849cd3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/renesas,rst.txt
> @@ -0,0 +1,35 @@
> +DT bindings for the Renesas R-Car Reset Controller
> +
> +The R-Car Reset Controller provides reset control, and implements the following
> +functions:
> +  - Latching of the levels on mode pins when PRESET# is negated,
> +  - Mode monitoring register,
> +  - Reset control of peripheral devices (on R-Car Gen1),
> +  - Watchdog timer (on R-Car Gen1).


Quite minor nit: s/./,/

Or drop all the ',' completely?


> +  - Register-based reset control and boot address registers for the various CPU
> +    cores (on R-Car Gen2/Gen3),

Best regards

Dirk
