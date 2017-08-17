From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Aug 2017 16:11:04 -0500
Subject: [PATCH v2 2/3] dt-bindings: Document STM32 CRYP bindings
In-Reply-To: <1502781584-18468-3-git-send-email-fabien.dessenne@st.com>
References: <1502781584-18468-1-git-send-email-fabien.dessenne@st.com>
 <1502781584-18468-3-git-send-email-fabien.dessenne@st.com>
Message-ID: <20170817211104.qiixtzbetrssp4k2@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 15, 2017 at 09:19:43AM +0200, Fabien Dessenne wrote:
> Document device tree bindings for the STM32 CRYP.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---
>  .../devicetree/bindings/crypto/st,stm32-cryp.txt     | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/st,stm32-cryp.txt
> 
> diff --git a/Documentation/devicetree/bindings/crypto/st,stm32-cryp.txt b/Documentation/devicetree/bindings/crypto/st,stm32-cryp.txt
> new file mode 100644
> index 0000000..7c6d599
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/st,stm32-cryp.txt
> @@ -0,0 +1,20 @@
> +* STMicroelectronics STM32 CRYP
> +
> +Required properties:
> +- compatible: Should be "st,stm32f756-cryp".
> +- reg: The address and length of the peripheral registers space
> +- clocks: The input clock of the CRYP instance
> +- interrupts: The CRYP interrupt
> +
> +Optional properties:
> +- resets: The input reset of the CRYP instance
> +
> +Example:
> +cryp1: cryp at 50060000 {

crypto at ..

> +	compatible = "st,stm32f756-cryp";
> +	reg = <0x50060000 0x400>;
> +	interrupts = <79>;
> +	clocks = <&rcc 0 STM32F7_AHB2_CLOCK(CRYP)>;
> +	resets = <&rcc STM32F7_AHB2_RESET(CRYP)>;
> +	status = "disabled";

Don't show status in examples.

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>

> +};
> -- 
> 2.7.4
> 
