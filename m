From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Fri, 23 Mar 2018 09:34:08 +0100
Subject: [PATCH 1/2][v6] dt-bindings: mtd-physmap: Add endianness supports
In-Reply-To: <20180312081128.8195-1-prabhakar.kushwaha@nxp.com>
References: <20180312081128.8195-1-prabhakar.kushwaha@nxp.com>
Message-ID: <20180323093408.230a61c1@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Mar 2018 13:41:28 +0530
Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com> wrote:

> Connection between flash and controller is not necessary to be always
> of same type. It may varies from platform to platform.
> 
> Adding endianness (optional) property to provide connection type
> information.
> 
> Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes for v2: updated subject
> Changes for v3: fixed typo for "big-endian"
> Changes for v4: Moved binding definition in mtd-physmap.txt
> as discussed at https://patchwork.ozlabs.org/patch/842543/
> Changes for v5: Sending as it is
> Changes for v6: Updated binding when endianness property is absent
> 
>  Documentation/devicetree/bindings/mtd/mtd-physmap.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
> index 4a0a48bf4ecb..691c98f7301d 100644
> --- a/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
> +++ b/Documentation/devicetree/bindings/mtd/mtd-physmap.txt
> @@ -41,6 +41,11 @@ additional (optional) property is defined:
>  
>   - erase-size : The chip's physical erase block size in bytes.
>  
> + The device tree may optionally contain endianness property.
> + little-endian or big-endian : It represents connection between controller and

You still haven't answered the comments I made on your v5. To me, this
does not represent how the controller and chip pins are connected, but
how the chip was programmed and which endianness should be used by the
controller to correctly read the data back. Maybe I'm wrong, hence my
question.

> +			flash. If this property is absent, connection is described
> +			by the CFI_DEFAULT_ENDIAN.

Nope, you can't refer to linux-specific config options in a DT binding,
because those bindings are supposed to be OS-agnostic. Maybe something
like "If this property is missing, the endianness is chosen by the
system (potentially based on extra configuration options).".

Rob, any suggestion other suggestion?

Regards,

Boris


-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
