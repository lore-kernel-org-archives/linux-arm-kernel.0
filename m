From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 27 Jun 2012 12:26:36 +0300
Subject: [PATCH v11 3/4] MTD: nand: add return value for
 write_page()/write_page_raw() functions in structure of nand_ecc_ctrl.
In-Reply-To: <1340618866-28776-4-git-send-email-josh.wu@atmel.com>
References: <1340618866-28776-1-git-send-email-josh.wu@atmel.com>
 <1340618866-28776-4-git-send-email-josh.wu@atmel.com>
Message-ID: <1340789196.29342.7.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-06-25 at 18:07 +0800, Josh Wu wrote:
> There is an implemention of hardware ECC write page function which may return an
> error indication.
> For instance, using Atmel HW PMECC to write one page into a nand flash, the hardware
> engine will compute the BCH ecc code for this page. so we need read a the
> status register to theck whether the ecc code is generated.
> But we cannot assume the status register always can be ready, for example,
> incorrect hardware configuration or hardware issue, in such case we need
> write_page() to return a error code.
> 
> Since the definition of 'write_page' function in struct nand_ecc_ctrl is 'void'.
> So this patch will:
>   1. add return 'int' value for 'write_page' function.
>   2. to be consitent, add return 'int' value for 'write_page_raw' fuctions too.
>   3. add code to test the return value, and if negative, indicate an
>   error happend when write page with ECC.
>   4. fix the compile warning in all impacted nand flash driver.
> 
> Note: I couldn't compile-test all of these easily, as some had ARCH dependencies.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

Pushed this patch to l2-mtd.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120627/9ff84927/attachment.sig>
