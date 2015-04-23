From: will.deacon@arm.com (Will Deacon)
Date: Thu, 23 Apr 2015 15:28:17 +0100
Subject: [PATCH] arm64: dma-mapping: always clear allocated buffers
In-Reply-To: <1429789576-19570-1-git-send-email-m.szyprowski@samsung.com>
References: <1429789576-19570-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20150423142816.GA16621@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 23, 2015 at 12:46:16PM +0100, Marek Szyprowski wrote:
> Buffers allocated by dma_alloc_coherent() are always zeroed on Alpha,
> ARM (32bit), MIPS, PowerPC, x86/x86_64 and probably other architectures.

That's pretty compelling, even if it sucks. Maybe we could add a debug
option to poison DMA buffers if __GFP_ZERO isn't passed? It might help
others avoid the painful debugging experience you had...

Will
