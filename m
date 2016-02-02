From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 2 Feb 2016 23:31:15 +0100
Subject: [PATCH v3 1/2] dt-bindings: add sun4i SPDIF transceiver bindings
In-Reply-To: <1454424594-25208-2-git-send-email-codekipper@gmail.com>
References: <1454424594-25208-1-git-send-email-codekipper@gmail.com>
 <1454424594-25208-2-git-send-email-codekipper@gmail.com>
Message-ID: <20160202223115.GE4652@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 02, 2016 at 03:49:53PM +0100, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> Add devicetree bindings for the SPDIF transceiver found on
> found on Allwinners A10 and A20 SoCs.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  .../devicetree/bindings/sound/sun4i,spdif.txt      | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/sun4i,spdif.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/sun4i,spdif.txt b/Documentation/devicetree/bindings/sound/sun4i,spdif.txt
> new file mode 100644
> index 0000000..55ed2f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/sun4i,spdif.txt
> @@ -0,0 +1,46 @@
> +Allwinner Sony/Philips Digital Interface Format (S/PDIF) Controller
> +
> +The Allwinner S/PDIF audio block is a transceiver that allows the
> +processor to receive and transmit digital audio via an coaxial cable or
> +a fibre cable.
> +
> +Required properties:
> +
> +  - compatible		: should be one of the following:
> +    - "allwinner,sun4i-a10-spdif": for the Allwinner A10 SoC
> +
> +  - reg			: Offset and length of the register set for the device.
> +
> +  - interrupts		: Contains the spdif interrupt.
> +
> +  - dmas		: Generic dma devicetree binding as described in
> +			  Documentation/devicetree/bindings/dma/dma.txt.
> +
> +  - dma-names		: Two dmas have to be defined, "tx" and "rx".
> +
> +  - clocks		: Contains an entry for each entry in clock-names.
> +
> +  - clock-names		: Includes the following entries:
> +	"apb"		  clock for the spdif bus.
> +	"spdif"		  clock for spdif controller.
> +
> +Optional:
> +
> +  - spdif-in		: Enable block for capturing an SPDIF signal.
> +
> +  - spdif-out		: Enable block for transmitting an SPDIF signal.

Is that a generic property? What values can it hold?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160202/b55261c4/attachment.sig>
