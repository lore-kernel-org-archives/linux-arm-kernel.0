From: mikedunn@newsguy.com (Mike Dunn)
Date: Tue, 27 Nov 2012 10:59:13 -0800
Subject: [PATCH v2] MTD: at91: atmel_nand: return bit flips for the PMECC
 read_page()
In-Reply-To: <1354013431-13598-1-git-send-email-josh.wu@atmel.com>
References: <1354013431-13598-1-git-send-email-josh.wu@atmel.com>
Message-ID: <50B50D81.3060401@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/2012 02:50 AM, Josh Wu wrote:
> This patch fix pmecc's read_page() to return maximum number of bitflips, 0 if uncorrectable.
> 
> In the commit: 3f91e94f7f511de74c0d2abe08672ccdbdd1961c ("mtd: nand: read_page() returns max_bitflips ()"),
> The ecc.read_page() is changed to return the maximum number of bitflips.
> And when meet uncorrectable bitflips it needs to return 0.
> 
> See the comment in nand.h:
>  * @read_page:	function to read a page according to the ECC generator
>  *		requirements; returns maximum number of bitflips corrected in
>  *		any single ECC step, 0 if bitflips uncorrectable, -EIO hw error
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> ---
> change since v1:
>   1. add detail commit message for the fix.
>   2. return 0 when meet uncorrectable bitflips according to Mike Dunn's suggestion.


Reviewed-by: Mike Dunn <mikedunn@newsguy.com>

I see now the pmecc controller patch in the git log.  Nice work.

Mike
