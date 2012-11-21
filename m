From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 21 Nov 2012 10:25:40 +0100
Subject: mtd: nand: mxc: oobfree layout?
In-Reply-To: <880504158.1762783.1353441918369.JavaMail.root@advansee.com>
References: <1214095427.1646097.1353358014121.JavaMail.root@advansee.com>
 <880504158.1762783.1353441918369.JavaMail.root@advansee.com>
Message-ID: <20121121092540.GP10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 09:05:18PM +0100, Beno?t Th?baudeau wrote:
> Dear Sascha Hauer,
> 
> I've seen in the history of mxc_nand.c that you have worked on the
> nand_ecclayout structs. The following things look abnormal. Can you confirm?
>  - nandv1_hw_eccoob_smallpage and nandv2_hw_eccoob_smallpage:
>     * Why are bytes 0 and 1 in oobfree? These bytes are used for bad block
>       information on the 16-bit variants of these 512-byte-page NANDs.

This is probably a bug. Very few people seem to use 16bit flashes.

>  - nandv1_hw_eccoob_largepage:
>     * According to the i.MX31 reference manual, the BI bytes of the spare area
>       buffers are not free to use. So why are bytes 5, 11, 27, 43 and 59 in
>       oobfree? On the contrary, if this note is a mistake in the RM, then why
>       are bytes 21, 37 and 53 not in oobfree?
>  - nandv2_hw_eccoob_smallpage, nandv2_hw_eccoob_largepage and
>    nandv2_hw_eccoob_4k:
>     * Why is byte 6 not in oobfree?

Probably bugs aswell. Most people do not use filesystems requiring OOB
data anymore, so bugs may stay uncovered for longer.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
