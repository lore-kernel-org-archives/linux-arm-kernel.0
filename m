From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Tue, 15 Jan 2013 14:26:00 +0200
Subject: [PATCH 1/3] MTD: at91: atmel_nand: for PMECC, add code to
 choose the ecc bits and sector size according to the ONFI parameter ECC
 requirement.
In-Reply-To: <1355912840-29501-2-git-send-email-josh.wu@atmel.com>
References: <1355912840-29501-1-git-send-email-josh.wu@atmel.com>
 <1355912840-29501-2-git-send-email-josh.wu@atmel.com>
Message-ID: <1358252760.2731.133.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I cannot compile this patch:

ERROR (phandle_references): Reference to non-existent node or label "pinctrl_ssc0_tx"

ERROR: Input tree has errors, aborting (use -f to force output)
make[2]: *** [arch/arm/boot/dts/at91sam9g20ek.dtb] Error 2


On Wed, 2012-12-19 at 18:27 +0800, Josh Wu wrote:
> This patch will check NAND flash's ecc minimum requirement in ONFI parameter. If it is equal or smaller than pmecc-cap in dtsi, then use ecc_bits in ONFI. otherwise, return an error since pmecc-cap in dtsi don't meet the ecc minimum reqirement.
> 
> This patch also check sector size (codeword) requirement in ONFI. If it is equal or bigger than sector_size in dtsi, then use the one of ONFI. otherwise return error.
> 
> Currently we don't support to read the ECC parameter in ONFI extended parameter page. So in that case we just use the value specified in dts.
> 
> For non-ONFI nand flash, we assume the minimum ecc requirement is 2bits in 512 bytes.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

Please, wrap the lines like kernel developers usually do.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130115/49c8872d/attachment.sig>
