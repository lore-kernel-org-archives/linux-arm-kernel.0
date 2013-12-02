From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 02 Dec 2013 15:33:45 +0400
Subject: =?UTF-8?B?UmU6IFtSRkMvUEFUQ0hdIE5BTkQgYnVzLXdpZHRoIGRldGVjdGlvbiBleHRy?=
 =?UTF-8?B?ZW1lIG1ha2VvdmVy?=
In-Reply-To: <1385732456-32696-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1385732456-32696-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1385984025.215304817@f198.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

> Here's my proposal, based in Pekon's latest work.
> 
> This patch removes the flash device bus-width configuration, prior to
> the device detection. With this modification, a NAND driver is no longer
> able to "force" the device width, and instead can only obtain the detected
> bus-width after the call to nand_scan_ident().
...
> Alexander: Could you try this patch and see if it's suitable for your needs?
> I think you should be able to use it to set the bus-width, without any need for
> a new DT property. You will have to split your nand_scan() call in an initial
> call to nand_scan_ident() and a final call to nand_scan_tail().

16-bit ONFI:

ONFI param page 0 valid
ONFI flash detected
NAND device: Manufacturer ID: 0x2c, Chip ID: 0xca (Micron MT29F2G16ABAEAWP), 256MiB, page size: 2048, OOB size: 64
Scanning device for bad blocks
1 ofpart partitions found on MTD device MT29F2G16ABAEAWP
Creating 1 MTD partitions on "MT29F2G16ABAEAWP":
0x000000000000-0x000010000000 : "nand-gpio"

8-bit non-ONFI:
NAND device: Manufacturer ID: 0xec, Chip ID: 0x76 (Samsung NAND 64MiB 3,3V 8-bit), 64MiB, page size: 512, OOB size: 16
Scanning device for bad blocks
1 ofpart partitions found on MTD device NAND 64MiB 3,3V 8-bit
Creating 1 MTD partitions on "NAND 64MiB 3,3V 8-bit":
0x000000000000-0x000004000000 : "nand-gpio"

Cannot test 8-bit ONFI, since have not such chip.

---
