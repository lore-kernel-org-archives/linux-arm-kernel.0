From: robh@kernel.org (Rob Herring)
Date: Mon, 18 Apr 2016 11:53:29 -0500
Subject: [PATCH 1/5] regulator: st-flashss: Add DT binding documentation
 for flashss regulator.
In-Reply-To: <1460474204-5351-2-git-send-email-peter.griffin@linaro.org>
References: <1460474204-5351-1-git-send-email-peter.griffin@linaro.org>
 <1460474204-5351-2-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160418165329.GA8367@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2016 at 04:16:40PM +0100, Peter Griffin wrote:
> This patch adds the DT doc for the flashss regulator driver which is
> found in stih407 based silicon.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  .../devicetree/bindings/regulator/st-flashss.txt   | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/st-flashss.txt
> 
> diff --git a/Documentation/devicetree/bindings/regulator/st-flashss.txt b/Documentation/devicetree/bindings/regulator/st-flashss.txt
> new file mode 100644
> index 0000000..04324d5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/st-flashss.txt
> @@ -0,0 +1,43 @@
> +ST Voltage regulator for FlashSS vsense
> +
> +This documents the voltage regulator driver which manages the vsense inside the ST flash

Bindings document h/w, not drivers.
> +sub-system that is used for configuring MMC, NAND, SPI voltages.
> +
> +Required properties:
> +- compatible:		Can be "st,vqmmc", "st,vnand" or "st,vspi" because it is shared
> +			among these devices inside the ST FlashSS.
> +- regulator-name:	Regulator name.
> +- reg:			The vsense top config base address in the flashSS hardware.
> +
> +Any property defined as part of the core regulator binding, in
> +Documentation/devicetree/bindings/regulator/regulator.txt can also be used.
> +
> +Example:
> +
> +vqmmc_reg: voltage-regulator {
> +	compatible = "st,vqmmc";
> +	regulator-name = "vqmmc0";
> +	/* Control register for the VSENSE Module */

I'm having a hard time understanding the relationship of FlashSS, VSENSE 
and the compatible strings. The binding looks suspect to me though. If 
VSENSE is a module, then I'd expect a compatible string for it.

Rob
