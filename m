From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 May 2015 17:18:25 +0200
Subject: [PATCH v3] arm/mm/dma-mapping.c: Add arm_coherent_dma_mmap
In-Reply-To: <1431003257-7794-1-git-send-email-mike.looijmans@topic.nl>
References: <1431003257-7794-1-git-send-email-mike.looijmans@topic.nl>
Message-ID: <2510023.oRzFOK8gGd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 May 2015 14:54:17 Mike Looijmans wrote:
> When dma-coherent transfers are enabled, the mmap call must
> not change the pg_prot flags in the vma struct.
> 
> Split the arm_dma_mmap into a common and specific parts,
> and add a "arm_coherent_dma_mmap" implementation that does
> not alter the page protection flags.
> 
> Tested on a topic-miami board (Zynq) using the ACP port
> to transfer data between FPGA and CPU using the Dyplo
> framework. Without this patch, byte-wise access to mmapped
> coherent DMA memory was about 20x slower because of the
> memory being marked as non-cacheable, and transfer speeds
> would not exceed 240MB/s.
> 
> After this patch, the mapped memory is cacheable and the
> transfer speed is again 600MB/s (limited by the FPGA) when
> the data is in the L2 cache, while data integrity is being
> maintained.
> 
> The patch has no effect on non-coherent DMA.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 

Looks good to me

Acked-by: Arnd Bergmann <arnd@arndb.de>
