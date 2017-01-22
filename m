From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 22 Jan 2017 15:40:00 +0100
Subject: [PATCH 09/22] mtd: add DT bindings for the Cortina Systems Gemini
 Flash
In-Reply-To: <20170122122119.10510-1-linus.walleij@linaro.org>
References: <20170122122119.10510-1-linus.walleij@linaro.org>
Message-ID: <fdc38613-18c2-3ae3-09e6-d8103c0a8f93@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2017 01:21 PM, Linus Walleij wrote:
> This adds device tree bindings for the Cortina systems Gemini
> flash controller, a simple physmap which however need a few
> syscon bits to be poked to operate properly.
> 
> Cc: Janos Laube <janos.dev@gmail.com>
> Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Looks pretty OK to me:
Reviewed-by: Marek Vasut <marek.vasut@gmail.com>

> ---
> MTD maintainers: please just apply this to the MTD tree when
> you are happy with it. It is functionally orthogonal to the rest
> of the series and is just in the series for context.
> ---
>  .../bindings/mtd/cortina,gemini-flash.txt          | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/cortina,gemini-flash.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/cortina,gemini-flash.txt b/Documentation/devicetree/bindings/mtd/cortina,gemini-flash.txt
> new file mode 100644
> index 000000000000..3fa1b34d69ad
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/cortina,gemini-flash.txt
> @@ -0,0 +1,24 @@
> +Flash device on Cortina Systems Gemini SoC
> +
> +This flash is regular CFI compatible (Intel or AMD extended) flash chips with
> +some special bits that can be controlled by the machine's system controller.
> +
> +Required properties:
> +- compatible : must be "cortina,gemini-flash", "cfi-flash";
> +- reg : memory address for the flash chip
> +- syscon : must be a phandle to the system controller
> +- bank-width : width in bytes of flash interface, should be <2>
> +
> +For the rest of the properties, see mtd-physmap.txt.
> +
> +The device tree may optionally contain sub-nodes describing partitions of the
> +address space. See partition.txt for more detail.
> +
> +Example:
> +
> +flash at 30000000 {
> +	compatible = "cortina,gemini-flash", "cfi-flash";
> +	reg = <0x30000000 0x01000000>;
> +	syscon = <&syscon>;
> +	bank-width = <2>;
> +};
> 


-- 
Best regards,
Marek Vasut
