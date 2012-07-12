From: david.woodhouse@intel.com (Woodhouse, David)
Date: Thu, 12 Jul 2012 07:28:10 +0000
Subject: mxc-nand fix for 3.5 (Was: Re: [PATCH v2] mtd mxc_nand: use
 32bit copy functions)
In-Reply-To: <20120712065722.GA592@pengutronix.de>
References: <1338279369-25915-1-git-send-email-s.hauer@pengutronix.de>
 <1340970369.3070.166.camel@sauron.fi.intel.com>
 <20120712065722.GA592@pengutronix.de>
Message-ID: <1342078088.30654.14.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-07-12 at 08:57 +0200, Uwe Kleine-K?nig wrote:
> The mxc_nand driver is completely useless with
> 
>         5775ba3 (mtd: mxc_nand: fix several sparse warnings about incorrect address space)
> 
> but without this patch. So it would be great if we could have it in 3.5.
> Or alternatively revert 5775ba3. This fix currently it sits as
> 
>         096bcc2 (mtd: mxc_nand: use 32bit copy functions)
> 
> in next/master. 

The subject of that commit didn't jump out at me when I was perusing the
patch queue for 3.5-worthy stuff.

Artem reminded me about it just after I sent my previous pull request to
Linus last week. I wanted to let it sit in linux-next for a little
while, but now...

Linus, please pull from
   git://git.infradead.org/linux-mtd.git for-linus-20120712

Late MTD fixes for 3.5:
 - fix 'sparse warning fix' regression which totally breaks MXC NAND
 - fix GPMI NAND regression when used with UBI
 - update/correct sysfs documentation for new 'bitflip_threshold' field
 - fix nandsim build failure

----
Herton Ronaldo Krzesinski (1):
      mtd: nandsim: don't open code a do_div helper

Mike Dunn (1):
      mtd: ABI documentation: clarification of bitflip_threshold

Sascha Hauer (2):
      mtd: mxc_nand: use 32bit copy functions
      mtd: gpmi-nand: fix read page when reading to vmalloced area

 Documentation/ABI/testing/sysfs-class-mtd |   17 ++++++-------
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c    |   10 ++++----
 drivers/mtd/nand/mxc_nand.c               |   37 ++++++++++++++++++++++-------
 drivers/mtd/nand/nandsim.c                |   12 +++-------
 4 files changed, 46 insertions(+), 30 deletions(-)

-- 
                   Sent with MeeGo's ActiveSync support.

David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation


-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4370 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120712/7d3ca2c4/attachment-0001.bin>
