From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 03 Dec 2012 16:35:16 +0200
Subject: [PATCH v2] MTD: at91: atmel_nand: return bit flips for the
 PMECC read_page()
In-Reply-To: <1354013431-13598-1-git-send-email-josh.wu@atmel.com>
References: <1354013431-13598-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1354545316.11583.14.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-11-27 at 18:50 +0800, Josh Wu wrote:
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

Pushed to l2-mtd.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121203/3dc8bf5f/attachment.sig>
