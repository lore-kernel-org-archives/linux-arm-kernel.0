From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 26 Nov 2013 12:33:03 +0530
Subject: [PATCH 06/12] mtd: nand: davinci: adjust DT properties to MTD
 generic
In-Reply-To: <4F5844B3A985794BA902E12C070812375F8D20@DNCE04.ent.ti.com>
References: <1384187188-5776-1-git-send-email-ivan.khoronzhuk@ti.com>,
 <1384187188-5776-7-git-send-email-ivan.khoronzhuk@ti.com>
 <4F5844B3A985794BA902E12C070812375F8D20@DNCE04.ent.ti.com>
Message-ID: <529447A7.1050605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 November 2013 10:31 PM, Khoronzhuk, Ivan wrote:
> The properties davinci-ecc-mode, davinci-nand-use-bbt, davinci-nand-buswidth
> are MTD generic. Correct names for them are: nand-ecc-mode, nand-on-flash-bbt,
> nand-bus-width accordingly. So rename them in dts and documentation.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
>  .../devicetree/bindings/mtd/davinci-nand.txt       |   25 ++++++++++++++++----
>  drivers/mtd/nand/davinci_nand.c                    |   11 ++++++---
>  2 files changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/davinci-nand.txt b/Documentation/devicetree/bindings/mtd/davinci-nand.txt
> index d2a3fc0..befaa5b 100644
> --- a/Documentation/devicetree/bindings/mtd/davinci-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/davinci-nand.txt
> @@ -37,7 +37,7 @@ Recommended properties :
>  - ti,davinci-mask-chipsel:     mask for chipselect address. Needed to mask
>                                 addresses for given chipselect.
> 
> -- ti,davinci-ecc-mode:         operation mode of the NAND ecc mode. ECC mode
> +- nand-ecc-mode:               operation mode of the NAND ecc mode. ECC mode
>                                 valid values for davinci driver:
>                                 - "none"
>                                 - "soft"
> @@ -45,10 +45,25 @@ Recommended properties :
> 
>  - ti,davinci-ecc-bits:         used ECC bits, currently supported 1 or 4.
> 
> -- ti,davinci-nand-buswidth:    buswidth 8 or 16.

Shouldn't we keep the documentation for existing bindings while just
marking them as deprecated?

Thanks,
Sekhar
