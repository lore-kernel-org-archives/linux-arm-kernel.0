From: balbi@ti.com (Felipe Balbi)
Date: Wed, 18 Apr 2012 13:15:20 +0300
Subject: [PATCH 1/8] ARM: OMAP: fix DMA vs memory ordering
In-Reply-To: <E1SKRqN-0004b4-Me@rmk-PC.arm.linux.org.uk>
References: <20120418100954.GK25053@n2100.arm.linux.org.uk>
 <E1SKRqN-0004b4-Me@rmk-PC.arm.linux.org.uk>
Message-ID: <20120418101519.GU13842@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 11:10:35AM +0100, Russell King wrote:
> Using coherent DMA memory with the OMAP DMA engine results in
> unpredictable behaviour due to memory ordering issues; as things stand,
> there is no guarantee that data written to coherent DMA memory will be
> visible to the DMA hardware.
> 
> This is because the OMAP dma_write() accessor contains no barriers,
> necessary on ARMv6 and above.  The effect of this can be seen in comments
> in the OMAP serial driver, which incorrectly talks about cache flushing
> for the coherent DMA stuff.
> 
> Rather than adding barriers to the accessors, add it in the DMA support
> code just before we enable DMA, and just after we disable DMA.  This
> avoids having barriers for every DMA register access.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

cool, should this go to stable too ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120418/e0c8a6c0/attachment.sig>
