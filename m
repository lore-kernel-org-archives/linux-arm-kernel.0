From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jul 2011 21:30:45 +0100
Subject: [PATCH 01/10] ARM: change ARM_DMA_ZONE_SIZE into a variable
In-Reply-To: <20110708121441.GD4812@n2100.arm.linux.org.uk>
References: <1309919442-20451-1-git-send-email-nicolas.pitre@linaro.org>
	<20110706230455.GZ8286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107062043180.14596@xanadu.home>
	<20110708121441.GD4812@n2100.arm.linux.org.uk>
Message-ID: <20110708203045.GT4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 01:14:41PM +0100, Russell King - ARM Linux wrote:
> It looks like ISA_DMA_THRESHOLD has become unused by most of the kernel,
> so yes, renaming it to "dma_zone_limit" would be more descriptive.  We
> should probably make dma_supported() be out-of-line anyway (which then
> means that dma_zone_limit doesn't have to be exported to drivers) - and
> I think the DMA bounce stuff needs cleaning up in dma_set_mask().

... and I now have a patch which does this, pending testing.  Once
I've tested it I'll send it out.
