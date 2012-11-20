From: benoit.thebaudeau@advansee.com (=?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=)
Date: Tue, 20 Nov 2012 21:05:18 +0100 (CET)
Subject: mtd: nand: mxc: oobfree layout?
In-Reply-To: <1214095427.1646097.1353358014121.JavaMail.root@advansee.com>
Message-ID: <880504158.1762783.1353441918369.JavaMail.root@advansee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sascha Hauer,

I've seen in the history of mxc_nand.c that you have worked on the
nand_ecclayout structs. The following things look abnormal. Can you confirm?
 - nandv1_hw_eccoob_smallpage and nandv2_hw_eccoob_smallpage:
    * Why are bytes 0 and 1 in oobfree? These bytes are used for bad block
      information on the 16-bit variants of these 512-byte-page NANDs.
 - nandv1_hw_eccoob_largepage:
    * According to the i.MX31 reference manual, the BI bytes of the spare area
      buffers are not free to use. So why are bytes 5, 11, 27, 43 and 59 in
      oobfree? On the contrary, if this note is a mistake in the RM, then why
      are bytes 21, 37 and 53 not in oobfree?
 - nandv2_hw_eccoob_smallpage, nandv2_hw_eccoob_largepage and
   nandv2_hw_eccoob_4k:
    * Why is byte 6 not in oobfree?

Best regards,
Beno?t
