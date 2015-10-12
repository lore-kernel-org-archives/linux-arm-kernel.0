From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Oct 2015 21:14:24 +0200
Subject: [PATCH v2] nvme: fix 32-bit build warning
In-Reply-To: <561C0599.1090904@fb.com>
References: <5851501.PBMrs03XFb@wuerfel> <20151012190339.GA31736@lst.de>
 <561C0599.1090904@fb.com>
Message-ID: <5683852.vTfiqtLZLZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 October 2015 13:10:17 Jens Axboe wrote:
> On 10/12/2015 01:03 PM, Christoph Hellwig wrote:
> > Looks good,
> >
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> >
> > Note that we're moved the nvme driver to a new directory in the
> > block tree, but I can rebase it for you if you want.
> 
> I man handled it on both branches, so we should be good.

Thanks! I already saw the move, and it caused another build error
when CONFIG_BLOCK is disabled. Do you have this one?

	Arnd

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 0089f78b4071..002a94abdbc4 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -1,6 +1,6 @@
 config BLK_DEV_NVME
 	tristate "NVM Express block device"
-	depends on PCI
+	depends on PCI && BLOCK
 	---help---
 	  The NVM Express driver is for solid state drives directly
 	  connected to the PCI or PCI Express bus.  If you know you
