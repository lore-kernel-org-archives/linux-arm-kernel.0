From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 1 Jun 2012 11:47:03 +0100
Subject: [RFC 05/34] dmaengine: PL08x: fix missed
 dma_transfer_direction fixup
In-Reply-To: <CACRpkdbzsBW6oJ+NpgGttuPe9FVBqyW=dXnH+Ebx=bw1xigJhQ@mail.gmail.com>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIrK-0006z2-CV@rmk-PC.arm.linux.org.uk>
 <CACRpkdbzsBW6oJ+NpgGttuPe9FVBqyW=dXnH+Ebx=bw1xigJhQ@mail.gmail.com>
Message-ID: <20120601104703.GC21245@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 08:47:30AM +0800, Linus Walleij wrote:
> On Tue, May 29, 2012 at 5:36 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> 
> > db8196df4 (dmaengine: move drivers to dma_transfer_direction) missed
> > fixing up the "DMA_NONE" case.
> >
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Looks like it should go into the -rc:s really?
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

I don't think it's a big problem, the two enums resolve to the same
value.  It's just that it would be nice for folk who decide to change
stuff to actually check their changes better, so we didn't end up with
additional churn.
