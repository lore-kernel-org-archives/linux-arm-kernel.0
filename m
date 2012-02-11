From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sat, 11 Feb 2012 13:28:12 +0200
Subject: [PATCH V3] MTD: atmel_nand: Update driver to support
 Programmable HW ECC controller
In-Reply-To: <1328491977-30448-1-git-send-email-hong.xu@atmel.com>
References: <1328491977-30448-1-git-send-email-hong.xu@atmel.com>
Message-ID: <1328959692.22240.103.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-02-06 at 09:32 +0800, Hong Xu wrote:
> +static int16_t *pmecc_get_index_of(struct atmel_nand_host *host)
> +{
> +       int16_t *p = (int16_t *)host->rom_base;

I did not really get into details, but you annotate rom_base with
__iomem, and then you have to cast it to int16_t in several - this does
not look very nice.

Could you please CC the arm list? There are much more people who can
give this code a review.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120211/275f8346/attachment.sig>
