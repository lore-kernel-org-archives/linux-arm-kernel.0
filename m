From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 29 Jan 2014 14:53:32 -0300
Subject: [RFC PATCH v2 03/14] of: mtd: add documentation for
 nand-ecc-level property
In-Reply-To: <1391006064-28890-4-git-send-email-b.brezillon.dev@gmail.com>
References: <1391006064-28890-1-git-send-email-b.brezillon.dev@gmail.com>
 <1391006064-28890-4-git-send-email-b.brezillon.dev@gmail.com>
Message-ID: <20140129175331.GA27143@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 03:34:13PM +0100, Boris BREZILLON wrote:
> nand-ecc-level property statically defines NAND chip's ECC requirements.
> 
> Signed-off-by: Boris BREZILLON <b.brezillon.dev@gmail.com>
> ---
>  Documentation/devicetree/bindings/mtd/nand.txt |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/nand.txt b/Documentation/devicetree/bindings/mtd/nand.txt
> index 03855c8..0c962296 100644
> --- a/Documentation/devicetree/bindings/mtd/nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/nand.txt
> @@ -3,5 +3,8 @@
>  - nand-ecc-mode : String, operation mode of the NAND ecc mode.
>    Supported values are: "none", "soft", "hw", "hw_syndrome", "hw_oob_first",
>    "soft_bch".
> +- nand-ecc-level : Two cells property defining the ECC level requirements.
> +  The first cell represent the strength and the second cell the ECC block size.
> +  E.g. : nand-ecc-level = <4 512>; /* 4 bits / 512 bytes */
>  - nand-bus-width : 8 or 16 bus width if not present 8
>  - nand-on-flash-bbt: boolean to enable on flash bbt option if not present false

Hm.. when was this proposal agreed? It seems I've missed the
discussion...

FWIW, we've already proposed an equivalent one, but it received no
feedback from the devicetree maintainers:

http://comments.gmane.org/gmane.linux.drivers.devicetree/58764

Maybe we can discuss about it now?

  nand-ecc-strength : integer ECC required strength.
  nand-ecc-size : integer step size associated to the ECC strength.

  vs.

  nand-ecc-level : Two cells property defining the ECC level requirements.
  The first cell represent the strength and the second cell the ECC block size.
  E.g. : nand-ecc-level = <4 512>; /* 4 bits / 512 bytes */

It's really the same proposal but with a different format, right?
IMHO, the former is more human-readable, but other than that I see no
difference.

Brian? DT-guys?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
