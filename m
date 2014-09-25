From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Sep 2014 00:36:51 +0200
Subject: [PATCH] of: amba: use of_dma_configure for AMBA devices
In-Reply-To: <20140922105515.GI30085@e104818-lin.cambridge.arm.com>
References: <90bd1ff3c93b827c12e1b3dc9ad3f227632d0f6e.1410954967.git.robin.murphy@arm.com>
 <20140918125535.GB17701@e104818-lin.cambridge.arm.com>
 <20140922105515.GI30085@e104818-lin.cambridge.arm.com>
Message-ID: <201409260036.51545.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 September 2014, Catalin Marinas wrote:
> On Thu, Sep 18, 2014 at 01:55:36PM +0100, Catalin Marinas wrote:
> > On Thu, Sep 18, 2014 at 12:35:32PM +0100, Robin Murphy wrote:
> > > On 17/09/14 19:05, Will Deacon wrote:
> > > > On Wed, Sep 17, 2014 at 06:47:19PM +0100, Rob Herring wrote:
> > > >> On Wed, Sep 17, 2014 at 12:03 PM, Will Deacon <will.deacon@arm.com> wrote:
> > > >>> On Wed, Sep 17, 2014 at 12:56:07PM +0100, Robin Murphy wrote:
> > > >>>> Commit 591c1e ("of: configure the platform device dma parameters)
> > > >>>> introduced a common mechanism to configure DMA from DT properties.
> > > >>>> AMBA devices created from DT can take advantage of this, too.
> > > >>>>
> > > >>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > >>>
> > > >>>    Acked-by: Will Deacon <will.deacon@arm.com>
> > > >>>
> > > >>> It would be great if the arm-soc guys can pick this up.
> > > >>
> > > >> Is this a dependency for something else? If so,
> > > >>
> > > >> Acked-by: Rob Herring <robh@kernel.org>
> > > >
> > > > Yeah, it's going to be needed by my IOMMU init rework so that AMBA devices
> > > > get registered with their IOMMUs.
> > > 
> > > Noob question: Does that mean I should resend (with ACKs) to 
> > > arm at kernel.org? (I wasn't entirely sure where this should go, hence just 
> > > throwing at the list with CCs)
> > 
> > If it is not part of a larger series you want to merge, Rob could pick
> > it up (he could add the acks as well).
> > 
> > Alternatively, I can get it via the arm64 tree together with an
> > additional patch removing the bus hooks in dma-mapping.c (maybe that's a
> > better option if no-one objects).
> 
> So I plan to take this patch via the arm64 tree together with the patch
> below (after some more testing):

Sounds good to me. If you haven't already done so, please add

Acked-by: Arnd Bergmann <arnd@arndb.de>


	Arnd
