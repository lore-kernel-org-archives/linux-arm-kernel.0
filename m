From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 23 Nov 2009 12:21:23 +0000
Subject: [PATCH 10/10] ARM: dma-mapping: switch ARMv7 DMA mappings to
	retain'memory' attribute
In-Reply-To: <E1NBvnm-0007rA-7T@rmk-PC.arm.linux.org.uk>
References: <E1NBvnm-0007rA-7T@rmk-PC.arm.linux.org.uk>
Message-ID: <1258978883.8088.21.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2009-11-21 at 19:39 +0000, Russell King - ARM Linux wrote:
> On ARMv7, it is invalid to map the same physical address multiple times
> with different memory types.  Since system RAM is already mapped as
> 'memory', subsequent remapping of it must retain this attribute.
> 
> However, DMA memory maps it as "strongly ordered".  Fix this by introducing
> 'pgprot_dmacoherent()' which provides the necessary page table bits for
> DMA mappings.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
