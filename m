From: fujita.tomonori@lab.ntt.co.jp (FUJITA Tomonori)
Date: Mon, 6 Sep 2010 08:32:45 +0900
Subject: [PATCH] arm: fix pci_set_consistent_dma_mask for dmabounce devices
In-Reply-To: <20100905112513.GB558@n2100.arm.linux.org.uk>
References: <20100901085738.GJ8142@n2100.arm.linux.org.uk>
	<20100902114937X.fujita.tomonori@lab.ntt.co.jp>
	<20100905112513.GB558@n2100.arm.linux.org.uk>
Message-ID: <20100906083105X.fujita.tomonori@lab.ntt.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 5 Sep 2010 12:25:13 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> > This restores the trick that had worked.
> > 
> > btw, I can't compile ARCH_IXP4XX without the following patch:
> > 
> > http://www.spinics.net/lists/arm-kernel/msg95933.html
> > 
> > =
> > From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> > Subject: [PATCH] arm: fix arm: fix pci_set_consistent_dma_mask for dmabounce devices
> > 
> > This fixes the regression caused by the commit
> > 6fee48cd330c68332f9712bc968d934a1a84a32a.
> > 
> > ARM needs to clip the dma coherent mask for dmabounce devices. This
> > restores the old trick.
> > 
> > Note that strictly speaking, the DMA API doesn't allow architectures
> > to do such but I'm not sure it's worth adding the new API to set the
> > dma mask that allows architectures to clip it.
> > 
> > Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> 
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Should I send this to Linus? Or Can I assume that someone in ARM camp
will do?
