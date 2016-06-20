From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 20 Jun 2016 13:52:07 +0200
Subject: [PATCH 0/3] mtd: nand: sunxi: fix SLC NAND support
In-Reply-To: <1465214354-31493-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1465214354-31493-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20160620135207.5559196a@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  6 Jun 2016 13:59:11 +0200
Boris Brezillon <boris.brezillon@free-electrons.com> wrote:

> Hello,
> 
> Those 3 patches aims a fixing support for SLC NANDs with rather small
> NAND pages (<= 4k).
> 
> The first patch promote 512 bytes ECC steps to 1k steps, which should
> both save a few OOB bytes and provide stronger ECC.
> The second patch checks the ECC step value, and rejects any NAND that
> requires ECC steps != 512 | 1024.
> The last patch implements ecc->write_subpage(), thus fixing a NULL
> pointer dereference when the NAND chip supports subpage write.

Applied.

> 
> Best Regards,
> 
> Boris
> 
> Boris Brezillon (3):
>   mtd: nand: sunxi: prefer 1k ECC blocks when applicable
>   mtd: nand: sunxi: check ecc->size values
>   mtd: nand: sunxi: fix subpage write
> 
>  drivers/mtd/nand/sunxi_nand.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
> 
