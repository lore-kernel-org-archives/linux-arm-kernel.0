From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 Jan 2010 08:59:38 +0000
Subject: [RFC 16/18] arm: msm: add arch_has_speculative_dfetch()
In-Reply-To: <1263256133.26505.49.camel@c-dwalke-linux.qualcomm.com>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
	<1263250057-26692-17-git-send-email-dwalker@codeaurora.org>
	<20100111233356.GJ7925@n2100.arm.linux.org.uk>
	<1263256133.26505.49.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20100112085938.GA26435@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 04:28:53PM -0800, Daniel Walker wrote:
> On Mon, 2010-01-11 at 23:33 +0000, Russell King - ARM Linux wrote:
> > On Mon, Jan 11, 2010 at 02:47:35PM -0800, Daniel Walker wrote:
> > > From: Steve Muckle <smuckle@quicinc.com>
> > > 
> > > The Scorpion CPU speculatively reads data into the cache. This
> > > may occur while a region of memory is being written via DMA, so
> > > that region must be invalidated when it is brought under CPU
> > > control after the DMA transaction finishes, assuming the DMA
> > > was either bidirectional or from the device.
> > > 
> > > Currently both a clean and invalidate are being done for
> > > DMA_BIDIRECTIONAL in dma_unmap_single. Only an invalidate should be
> > > required here. There are drivers that currently rely on the clean
> > > however so this will be removed when those drivers are updated.
> > 
> > NAK.  There are patches around (and potentially queued) for the next
> > merge window which properly address this.
> 
> Do you have any hints on who's doing the development ?

Me, and they've been posted to this mailing list a few times in the last
months.
