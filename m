From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 16 Jul 2012 18:12:49 +0300
Subject: [PATCH v4 0/2] add gpmi support for imx6q
In-Reply-To: <1341279572-6098-1-git-send-email-shijie8@gmail.com>
References: <1341279572-6098-1-git-send-email-shijie8@gmail.com>
Message-ID: <1342451569.7270.11.camel@brekeke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-07-02 at 21:39 -0400, Huang Shijie wrote:
> This patch set adds the gpmi-nand support for imx6q.

Shawn's ack would be nice to have. BTW, aiaiai complains like this about
your driver:

drivers/mtd/nand/gpmi-nand/gpmi-nand.c:327:11: warning: incorrect type in assignment (different address spaces) [sparse]
drivers/mtd/nand/gpmi-nand/gpmi-nand.c:327:11:    expected void *p [sparse]
drivers/mtd/nand/gpmi-nand/gpmi-nand.c:327:11:    got void [noderef] <asn:2>* [sparse]
drivers/mtd/nand/gpmi-nand/gpmi-nand.c:347:28: warning: incorrect type in argument 1 (different address spaces) [sparse]
drivers/mtd/nand/gpmi-nand/gpmi-nand.c:347:28:    expected void volatile [noderef] <asn:2>*addr [sparse]
drivers/mtd/nand/gpmi-nand/gpmi-nand.c:347:28:    got void *gpmi_regs [sparse]
drivers/mtd/nand/gpmi-nand/gpmi-nand.c:349:28: warning: incorrect type in argument 1 (different address spaces) [sparse]
drivers/mtd/nand/gpmi-nand/gpmi-nand.c:349:28:    expected void volatile [noderef] <asn:2>*addr [sparse]
drivers/mtd/nand/gpmi-nand/gpmi-nand.c:349:28:    got void *bch_regs [sparse]
drivers/mtd/nand/gpmi-nand/gpmi-nand.c:1464:6: warning: symbol 'gpmi_nfc_exit' was not declared. Should it be static? [sparse]
drivers/mtd/nand/gpmi-nand/gpmi-nand.c:670 gpmi_alloc_dma_buffer() error: no modifiers for allocation. [smatch]
drivers/mtd/nand/gpmi-nand/gpmi-nand.c:675 gpmi_alloc_dma_buffer() error: no modifiers for allocation. [smatch]
drivers/mtd/nand/gpmi-nand/gpmi-nand.c: In function 'mx23_check_transcription_stamp':
drivers/mtd/nand/gpmi-nand/gpmi-nand.c:1198:9: warning: variable 'byte' set but not used [-Wunused-but-set-variable]
drivers/mtd/nand/gpmi-nand/gpmi-nand.c: In function 'mx23_write_transcription_stamp':
drivers/mtd/nand/gpmi-nand/gpmi-nand.c:1259:15: warning: variable 'byte' set but not used [-Wunused-but-set-variable]
drivers/mtd/nand/gpmi-nand/gpmi-nand.c: At top level:
drivers/mtd/nand/gpmi-nand/gpmi-nand.c:1464:6: warning: no previous prototype for 'gpmi_nfc_exit' [-Wmissing-prototypes]

I did not check whether they are false-positives or not, but some of
these are reasonable warnings - could you please take a look and
possibly fix?

To make sure the line numbers are the same for you, I've attached the
gpmi-nand.c which was tested.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: gpmi-nand.c
Type: text/x-csrc
Size: 47854 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120716/d30403a5/attachment-0001.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120716/d30403a5/attachment-0001.sig>
