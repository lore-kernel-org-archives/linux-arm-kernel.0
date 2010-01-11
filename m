From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jan 2010 23:33:56 +0000
Subject: [RFC 16/18] arm: msm: add arch_has_speculative_dfetch()
In-Reply-To: <1263250057-26692-17-git-send-email-dwalker@codeaurora.org>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
	<1263250057-26692-17-git-send-email-dwalker@codeaurora.org>
Message-ID: <20100111233356.GJ7925@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 02:47:35PM -0800, Daniel Walker wrote:
> From: Steve Muckle <smuckle@quicinc.com>
> 
> The Scorpion CPU speculatively reads data into the cache. This
> may occur while a region of memory is being written via DMA, so
> that region must be invalidated when it is brought under CPU
> control after the DMA transaction finishes, assuming the DMA
> was either bidirectional or from the device.
> 
> Currently both a clean and invalidate are being done for
> DMA_BIDIRECTIONAL in dma_unmap_single. Only an invalidate should be
> required here. There are drivers that currently rely on the clean
> however so this will be removed when those drivers are updated.

NAK.  There are patches around (and potentially queued) for the next
merge window which properly address this.
