From: imp@bsdimp.com (Warner Losh)
Date: Wed, 12 Mar 2014 12:27:40 -0600
Subject: [PATCH v3 4/9] of: mtd: add documentation for the ONFI NAND
 timing mode property
In-Reply-To: <1394647664-8258-5-git-send-email-b.brezillon.dev@gmail.com>
References: <1394647664-8258-1-git-send-email-b.brezillon.dev@gmail.com>
 <1394647664-8258-5-git-send-email-b.brezillon.dev@gmail.com>
Message-ID: <F8865D0A-59A7-41A7-AA7F-9B91DF5C8258@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mar 12, 2014, at 12:07 PM, Boris BREZILLON <b.brezillon.dev@gmail.com> wrote:

> Add documentation for the ONFI NAND timing mode property.

I don?t see a Toggle/JEDEC mode timing property. Will that be defined for Toshiba, Samsung
and San Disk flash? Or will this be limited to Micron, Intel and Hynix (the only ones
supporting ONFI)?

Warner


> Signed-off-by: Boris BREZILLON <b.brezillon.dev@gmail.com>
> ---
> Documentation/devicetree/bindings/mtd/nand.txt |    8 ++++++++
> 1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/nand.txt b/Documentation/devicetree/bindings/mtd/nand.txt
> index b53f92e..2046027 100644
> --- a/Documentation/devicetree/bindings/mtd/nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/nand.txt
> @@ -19,3 +19,11 @@ errors per {size} bytes".
> The interpretation of these parameters is implementation-defined, so not all
> implementations must support all possible combinations. However, implementations
> are encouraged to further specify the value(s) they support.
> +
> +- onfi,nand-timing-mode: an integer encoding the supported ONFI timing modes of
> +  the NAND chip. Each supported mode is represented as a bit position (i.e. :
> +  mode 0 and 1 => (1 << 0) | (1 << 1) = 0x3).
> +  This is only used when the chip does not support the ONFI standard.
> +  The last bit set represent the closest mode fulfilling the NAND chip timings.
> +  For a full description of the different timing modes see this document:
> +  www.onfi.org/~/media/ONFI/specs/onfi_3_1_spec.pdf
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
