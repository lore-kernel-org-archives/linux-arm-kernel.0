From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Wed, 22 Dec 2010 11:57:05 +0900
Subject: [PATCH 1/2] ARM: convert dma-mapping to asm-generic API
In-Reply-To: <20101221110135.GE2822@pulham.picochip.com>
References: <1292926802-12326-1-git-send-email-jamie@jamieiles.com>
	<20101221103652.GL28157@n2100.arm.linux.org.uk>
	<20101221110135.GE2822@pulham.picochip.com>
Message-ID: <20101222115705W.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 21 Dec 2010 11:01:35 +0000
Jamie Iles <jamie@jamieiles.com> wrote:

> On Tue, Dec 21, 2010 at 10:36:52AM +0000, Russell King - ARM Linux wrote:
> > On Tue, Dec 21, 2010 at 10:20:01AM +0000, Jamie Iles wrote:
> > > Note: this patch also requires "ARM: dmabounce: fix partial sync in
> > > dma_sync_single_* API" from FUJITA Tomonori:
> > > 
> > > 	http://www.spinics.net/lists/netdev/msg126826.html
> > > 
> > > which allows us to do fuzzy matching of the buffers when using
> > > dmabounce.
> > 
> > Which I've already said no to.
> 
> Ok, perhaps I missed some other posts. From that thread the only objections I 
> found were to do with the indentation style and they were fixed up.
> 
> > I don't believe that the direction taken there is anywhere near the right
> > one - the approach we have (implementing the whole buffer sync in terms
> > of the partial buffer sync) is the far more logical, simpler and safer
> > way, and doesn't lead to the possibility of two partially overlapping
> > mappings causing the wrong one to be operated upon.
> > 
> > The debug code doesn't check for overlapping mappings in any way, so we
> > can't say that they never occur.
> >
> > With the way that the DMA API has gone, I view the "generic" stuff as
> > a disaster.
> 
> Ok I can't disagree with that. I've had a look at some of the other arches and 
> I can't see an obvious reason why we couldn't change the generic 
> implementation to do the sync in the way you describe. Perhaps I'll have a 
> look at that after the holidays.

You need to examine all the network drivers and fix some of them.
