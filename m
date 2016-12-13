From: robh@kernel.org (Rob Herring)
Date: Tue, 13 Dec 2016 14:06:20 -0600
Subject: [PATCH v2 2/2] crypto: mediatek - add DT bindings documentation
In-Reply-To: <1481592676-2248-3-git-send-email-ryder.lee@mediatek.com>
References: <1481592676-2248-1-git-send-email-ryder.lee@mediatek.com>
 <1481592676-2248-3-git-send-email-ryder.lee@mediatek.com>
Message-ID: <20161213200620.kh34dptxpdcbhkhl@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2016 at 09:31:16AM +0800, Ryder Lee wrote:
> Add DT bindings documentation for the crypto driver
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../devicetree/bindings/crypto/mediatek-crypto.txt | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/mediatek-crypto.txt
> 
> diff --git a/Documentation/devicetree/bindings/crypto/mediatek-crypto.txt b/Documentation/devicetree/bindings/crypto/mediatek-crypto.txt
> new file mode 100644
> index 0000000..47a786e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/mediatek-crypto.txt
> @@ -0,0 +1,32 @@
> +MediaTek cryptographic accelerators
> +
> +Required properties:
> +- compatible: Should be "mediatek,eip97-crypto"
> +- reg: Address and length of the register set for the device
> +- interrupts: Should contain the five crypto engines interrupts in numeric
> +	order. These are global system and four descriptor rings.
> +- clocks: the clock used by the core
> +- clock-names: the names of the clock listed in the clocks property. These are
> +	"ethif", "cryp"
> +- power-domains: Must contain a reference to the PM domain.
> +
> +
> +Optional properties:
> +- interrupt-parent: Should be the phandle for the interrupt controller
> +  that services interrupts for this device

This is not optional. It's perhaps inherited from the parent. You can 
drop it as it's implied by interrupts property.

Rob
