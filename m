From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Sun, 11 Jun 2017 10:53:53 +0200
Subject: [PATCH v6 1/5] Documentation/bindings: Document the SafeXel
 cryptographic engine driver
In-Reply-To: <20170524141035.21031-2-antoine.tenart@free-electrons.com>
References: <20170524141035.21031-1-antoine.tenart@free-electrons.com>
 <20170524141035.21031-2-antoine.tenart@free-electrons.com>
Message-ID: <20170611085353.GG31464@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Herbert,

On Wed, May 24, 2017 at 04:10:31PM +0200, Antoine Tenart wrote:
> The Inside Secure Safexcel cryptographic engine is found on some Marvell
> SoCs (7k/8k). Document the bindings used by its driver.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Since you applied the Safexcel crypto driver patch, I think you should
also apply this patch adding the corresponding bindings documentation.

Thanks!
Antoine

> ---
>  .../bindings/crypto/inside-secure-safexcel.txt     | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/inside-secure-safexcel.txt
> 
> diff --git a/Documentation/devicetree/bindings/crypto/inside-secure-safexcel.txt b/Documentation/devicetree/bindings/crypto/inside-secure-safexcel.txt
> new file mode 100644
> index 000000000000..f69773f4252b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/inside-secure-safexcel.txt
> @@ -0,0 +1,29 @@
> +Inside Secure SafeXcel cryptographic engine
> +
> +Required properties:
> +- compatible: Should be "inside-secure,safexcel-eip197".
> +- reg: Base physical address of the engine and length of memory mapped region.
> +- interrupts: Interrupt numbers for the rings and engine.
> +- interrupt-names: Should be "ring0", "ring1", "ring2", "ring3", "eip", "mem".
> +
> +Optional properties:
> +- clocks: Reference to the crypto engine clock.
> +- dma-mask: The address mask limitation. Defaults to 64.
> +
> +Example:
> +
> +	crypto: crypto at 800000 {
> +		compatible = "inside-secure,safexcel-eip197";
> +		reg = <0x800000 0x200000>;
> +		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "mem", "ring0", "ring1", "ring2", "ring3",
> +				  "eip";
> +		clocks = <&cpm_syscon0 1 26>;
> +		dma-mask = <0xff 0xffffffff>;
> +		status = "disabled";
> +	};
> -- 
> 2.9.4
> 

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170611/43206d9e/attachment.sig>
