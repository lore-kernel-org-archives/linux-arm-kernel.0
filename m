From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 23 May 2012 11:54:02 +0200
Subject: [PATCH v8 2/3] MTD: add dt parameters for PMECC
In-Reply-To: <1337759274-9921-3-git-send-email-josh.wu@atmel.com>
References: <1337759274-9921-1-git-send-email-josh.wu@atmel.com>
 <1337759274-9921-3-git-send-email-josh.wu@atmel.com>
Message-ID: <20120523095402.GF3377@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:47 Wed 23 May     , Josh Wu wrote:
> Signed-off-by: Hong Xu <hong.xu@atmel.com>
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> ---
>  .../devicetree/bindings/mtd/atmel-nand.txt         |    7 +++++++
>  drivers/mtd/nand/atmel_nand.c                      |   20 ++++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> index a200695..895d72b 100644
> --- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> @@ -16,6 +16,12 @@ Optional properties:
>  - nand-ecc-mode : String, operation mode of the NAND ecc mode, soft by default.
>    Supported values are: "none", "soft", "hw", "hw_syndrome", "hw_oob_first",
>    "soft_bch".
> +- atmel,has-pmecc : boolean to enable Programmable Multibit ECC hardware.
> +  Only supported by at91sam9x5 or later sam9 product.
> +- atmel,pmecc-cap : error correct capability for Programmable Multibit ECC
> +  Controller. Supported values are: 2, 4, 8, 12, 24.
> +- atmel,sector-size : sector size for ECC computation. Supported values are:
> +  512, 1024.
pmecc-sector-size as it's pmecc specific

Best Regards,
J.
