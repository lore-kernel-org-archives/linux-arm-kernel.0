From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Sep 2016 12:44:35 -0500
Subject: [PATCH] mtd: s3c2410: add device tree support
In-Reply-To: <1474125760-28168-1-git-send-email-sergio.prado@e-labworks.com>
References: <1474125760-28168-1-git-send-email-sergio.prado@e-labworks.com>
Message-ID: <20160923174435.GA29914@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 17, 2016 at 12:22:40PM -0300, Sergio Prado wrote:
> Tested on FriendlyARM Mini2440
> 
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> ---
>  .../devicetree/bindings/mtd/samsung-s3c2410.txt    |  70 +++++++++++
>  drivers/mtd/nand/s3c2410.c                         | 129 ++++++++++++++++++++-
>  include/linux/platform_data/mtd-nand-s3c2410.h     |   1 +
>  3 files changed, 195 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/samsung-s3c2410.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/samsung-s3c2410.txt b/Documentation/devicetree/bindings/mtd/samsung-s3c2410.txt
> new file mode 100644
> index 000000000000..1c39f6cf483b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/samsung-s3c2410.txt
> @@ -0,0 +1,70 @@
> +* Samsung S3C2410 and compatible NAND flash controller
> +
> +Required properties:
> +- compatible : The possible values are:
> +	"samsung,s3c2410-nand"
> +	"samsung,s3c2412-nand"
> +	"samsung,s3c2440-nand"
> +	"samsung,s3c6400-nand"
> +- reg : register's location and length.
> +- #address-cells, #size-cells : see nand.txt
> +- clocks : phandle to the nand controller clock
> +- clock-names : must contain "nand"
> +
> +Optional properties:
> +- samsung,tacls : time for active CLE/ALE to nWE/nOE
> +- samsung,twrph0 : active time for nWE/nOE
> +- samsung,twrph1 : time for release CLE/ALE from nWE/nOE inactive
> +- samsung,ignore_unset_ecc : boolean to ignore error when we have

Use '-', not '_'.

> +                             0xff,0xff,0xff read ECC, on the
> +                             assumption that it is an un-eccd page
> +
> +Optional children nodes:
> +Children nodes representing the available nand chips.

s/Children/Child/

> +
> +Optional children properties:
> +- nand-ecc-mode : see nand.txt
> +- nand-on-flash-bbt : see nand.txt
> +
> +Each children device node may optionally contain a 'partitions' sub-node,

s/children/child/

> +which further contains sub-nodes describing the flash partition mapping.
> +See partition.txt for more detail.
