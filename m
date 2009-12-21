From: jamie.iles@picochip.com (Jamie Iles)
Date: Mon, 21 Dec 2009 09:08:16 +0000
Subject: [PATCH] armv6: invalidate cache on
	DMA_FROM_DEVICE/DMA_BIDIRECTIONAL
In-Reply-To: <1261357222-18470-1-git-send-email-jamie.iles@picochip.com>
References: <1261357222-18470-1-git-send-email-jamie.iles@picochip.com>
Message-ID: <1261386497-2924-1-git-send-email-jamie.iles@picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've just noticed that we can also defer the invalidation from the
v6_dma_map_area to v6_dma_unmap_area. The following patch cleans the cache
for DMA_TO_DEVICE and DMA_BIDIRECTIONAL on mapping but does no invalidation.
