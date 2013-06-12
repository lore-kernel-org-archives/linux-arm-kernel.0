From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 12 Jun 2013 11:01:54 +0530
Subject: [PATCH 2/9] dma: pl330: use dma_addr_t for describing bus
 addresses
In-Reply-To: <CAJe_ZheKMVQgq42Vx5N1TXXdgFJ2sp50ixU30A7beXhmSVHnZQ@mail.gmail.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
 <1370889285-22799-3-git-send-email-will.deacon@arm.com>
 <CAJe_ZheKMVQgq42Vx5N1TXXdgFJ2sp50ixU30A7beXhmSVHnZQ@mail.gmail.com>
Message-ID: <20130612053154.GE4107@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 10:07:12AM +0530, Jassi Brar wrote:
> On 11 June 2013 00:04, Will Deacon <will.deacon@arm.com> wrote:
> 
> > The microcode bus address (pl330_dmac.mcode_bus) is currently a u32,
> > which fails to compile when building on a system with 64-bit bus
> > addresses.
> >
> > This patch uses dma_addr_t to represent the address instead.
> >
> > Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
> 
> 
> > Cc: Jassi Brar <jaswinder.singh@linaro.org>
> > Cc: Vinod Koul <vinod.koul@intel.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
Applied, thanks

--
~Vinod
> > ---
> >  drivers/dma/pl330.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
> > index 22e2a8f..f1bc593 100644
> > --- a/drivers/dma/pl330.c
> > +++ b/drivers/dma/pl330.c
> > @@ -501,7 +501,7 @@ struct pl330_dmac {
> >         /* Maximum possible events/irqs */
> >         int                     events[32];
> >         /* BUS address of MicroCode buffer */
> > -       u32                     mcode_bus;
> > +       dma_addr_t              mcode_bus;
> >         /* CPU address of MicroCode buffer */
> >         void                    *mcode_cpu;
> >         /* List of all Channel threads */
> > --
> > 1.8.2.2
> >
> >
> 
> 
> -- 
> Linaro.org ? Open source software for ARM SoCs | Follow Linaro
> http://facebook.com/pages/Linaro/155974581091106  -
> http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog

-- 
