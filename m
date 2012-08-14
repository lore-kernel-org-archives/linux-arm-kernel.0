From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Aug 2012 09:20:47 +0100
Subject: [PATCH v3 3/4] dmatest: add dmaengine_slave_config for DMA_MEMCPY
In-Reply-To: <1344917519-9505-4-git-send-email-zhangfei.gao@marvell.com>
References: <1344917519-9505-1-git-send-email-zhangfei.gao@marvell.com>
 <1344917519-9505-4-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <20120814082047.GF18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 12:11:58PM +0800, Zhangfei Gao wrote:
> Set direction to DMA_MEM_TO_MEM
> DMA driver may require such configure info

No, this is wrong.  By default, any channel being asked to do memcpy
should deal with the channel configuration itself and not require it
to be set - otherwise this breaks the async_tx API.

So consider that dma-test found a bug in your driver which needs fixing.
