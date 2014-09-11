From: shijie8@gmail.com (Huang Shijie)
Date: Thu, 11 Sep 2014 20:09:30 +0800
Subject: [PATCH] mtd: nand: gpmi: add proper raw access support
In-Reply-To: <1410339339-25561-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1410339339-25561-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140911120928.GA1585@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 10:55:39AM +0200, Boris BREZILLON wrote:
> Several MTD users (either in user or kernel space) expect a valid raw
> access support to NAND chip devices.
> This is particularly true for testing tools which are often touching the
> data stored in a NAND chip in raw mode to artificially generate errors.
> 
> The GPMI drivers do not implemenent raw access functions, and thus rely on
> default HW_ECC scheme implementation.
> The default implementation consider the data and OOB area as properly
> separated in their respective NAND section, which is not true for the GPMI
> controller.
> In this driver/controller some OOB data are stored at the beginning of the
> NAND data area (these data are called metadata in the driver), then ECC
> bytes are interleaved with data chunk (which is similar to the
> HW_ECC_SYNDROME scheme), and eventually the remaining bytes are used as
> OOB data.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> ---
> Hello,
> 
> This patch is providing raw access support to the GPMI driver which is
> particularly useful to run some tests on the NAND (the one coming in
> mind is the mtd_nandbiterrs testsuite).
> 
> I know this rework might break several user space tools which are relying
> on the default raw access implementation (I already experienced an issue
> with the kobs-ng tool provided by freescale), but many other tools will
> now work as expected.
If the kobs-ng can not works, there is no meaning that other tools
works.  So I do not think we need to implement these hooks. 

sorry, I will not Ack this patch.

thanks
Huang Shijie
