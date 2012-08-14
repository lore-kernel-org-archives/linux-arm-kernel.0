From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Aug 2012 09:30:26 +0100
Subject: [PATCH v3 1/4] dmaengine: mmp-pdma support
In-Reply-To: <1344917519-9505-2-git-send-email-zhangfei.gao@marvell.com>
References: <1344917519-9505-1-git-send-email-zhangfei.gao@marvell.com>
 <1344917519-9505-2-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <20120814083026.GG18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please consider looking at the virtual dma channel support, which I've
recently added.  This removes the burden of managing the descriptor
lists from the driver, deals with the workqueues for completing
descriptors, etc.

All you need to do is to build the descriptors for the DMA operation,
manage the scheduling of virtual channels onto physical channels,
calculate the position of DMA, and starting off and handling the DMA
hardware.

"virtual dma channel support" is probably something of a misnomer though;
it can also be used for situations where there's a 1:1 binding between
virtual and physical dma channels (iow, no virtual channels at all.)
