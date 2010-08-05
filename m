From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 5 Aug 2010 11:03:33 -0400 (EDT)
Subject: [PATCH] usb: musb: host: Issue a memory barrier before staring
	the DMA
In-Reply-To: <1281001990-29755-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <Pine.LNX.4.44L0.1008051102210.1944-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 5 Aug 2010, Santosh Shilimkar wrote:

> This patch fixes the issue which was observed while transfering
> a large file ( > 20MB) over USB (OMAP MUSB controller acts as USB host)
> to an attached USB thumb drive.
> 
> It was found that CDB field of CBW packet was set to 0x0. This was
> due to missing a barrier before DMA engine starts transfer.
> This  buffer is  allocated using dma_alloc_coherent which gives
> non-cacheble but bufferable memory and hence needed a write
> memory barrier to flush the write buffer.

If you see this problem when the controller uses DMA acting as a host,
does this mean the same problem might occur when it uses DMA acting as
a peripheral?

Alan Stern
