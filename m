From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 19 Sep 2018 14:21:57 -0700
Subject: [PATCH 1/2] dt-bindings: pinctrl: document Broadcom Northstar pin
 mux controller
In-Reply-To: <20180919210219.21921-1-zajec5@gmail.com>
References: <20180919210219.21921-1-zajec5@gmail.com>
Message-ID: <7e381fba-a7bf-f587-7bbf-d6b30d9874c9@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2018 02:02 PM, Rafa? Mi?ecki wrote:
> From: Rafa? Mi?ecki <rafal@milecki.pl>
> 
> Northstar has mux controller just like Northstar Plus and Northstar2.
> It's a bit different though (different registers & pins) so it requires
> its own binding.
> 
> It's needed to allow other block bindings specify required mux setup.
> 
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
> ---
>  .../devicetree/bindings/pinctrl/brcm,ns-pinmux.txt | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,ns-pinmux.txt
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,ns-pinmux.txt b/Documentation/devicetree/bindings/pinctrl/brcm,ns-pinmux.txt
> new file mode 100644
> index 000000000000..0e913721ae9e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/brcm,ns-pinmux.txt
> @@ -0,0 +1,29 @@
> +Broadcom Northstar pins mux controller
> +
> +Some of Northstar SoCs's pins can be used for various purposes thanks to the mux
> +controller. This binding allows describing mux controller and listing available
> +functions. They can be referenced later by other bindings to let system
> +configure controller correctly.
> +
> +Required properties:
> +- compatible: brcm,ns-pinmux
> +- reg: iomem address range of CRU (Central Resource Unit) pin registers
> +- reg-names: "cru_pins_control" - the only needed & supported reg right now

Technically the register range that you cover is named CRU_GPIO_CONTROLx
with x being in [0-8].

Other than that:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
