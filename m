From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 5 Sep 2010 12:25:13 +0100
Subject: [PATCH] arm: fix pci_set_consistent_dma_mask for dmabounce devices
In-Reply-To: <20100902114937X.fujita.tomonori@lab.ntt.co.jp>
References: <20100819174426O.fujita.tomonori@lab.ntt.co.jp>
	<m3sk1yzkjw.fsf@intrepid.localdomain>
	<20100901085738.GJ8142@n2100.arm.linux.org.uk>
	<20100902114937X.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <20100905112513.GB558@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 02, 2010 at 11:50:33AM +0900, FUJITA Tomonori wrote:
> On Wed, 1 Sep 2010 09:57:38 +0100
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > On Sat, Aug 28, 2010 at 07:58:11PM +0200, Krzysztof Halasa wrote:
> > > What's the outcome of the following?
> > > 
> > > Russell, are you going to apply it as is, or is a better (short-term)
> > > fix being made?
> > 
> > I want to see a better solution to this first - without which we'll
> > apply this hack and then quietly forget about the problem.
> 
> This restores the trick that had worked.
> 
> btw, I can't compile ARCH_IXP4XX without the following patch:
> 
> http://www.spinics.net/lists/arm-kernel/msg95933.html
> 
> =
> From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Subject: [PATCH] arm: fix arm: fix pci_set_consistent_dma_mask for dmabounce devices
> 
> This fixes the regression caused by the commit
> 6fee48cd330c68332f9712bc968d934a1a84a32a.
> 
> ARM needs to clip the dma coherent mask for dmabounce devices. This
> restores the old trick.
> 
> Note that strictly speaking, the DMA API doesn't allow architectures
> to do such but I'm not sure it's worth adding the new API to set the
> dma mask that allows architectures to clip it.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks.
