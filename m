From: will.deacon@arm.com (Will Deacon)
Date: Wed, 25 Jul 2018 17:06:10 +0100
Subject: [PATCH 02/10] mm: workingset: tell cache transitions from
 workingset thrashing
In-Reply-To: <20180724150448.GA25412@arm.com>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-3-hannes@cmpxchg.org>
 <CAK8P3a3Nsmt54-ed_gWNev3CBS6_Sv5QGOw4G0sY4ZXOi1R4_Q@mail.gmail.com>
 <20180723152323.GA3699@cmpxchg.org>
 <CAK8P3a15K-TXYuFX-ZsJiroqA1GWX2XS4ioZSjcjJYgh1b_xSA@mail.gmail.com>
 <20180723162735.GA5980@cmpxchg.org>
 <20180724150448.GA25412@arm.com>
Message-ID: <20180725160610.GD6866@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2018 at 04:04:48PM +0100, Will Deacon wrote:
> On Mon, Jul 23, 2018 at 12:27:35PM -0400, Johannes Weiner wrote:
> > On Mon, Jul 23, 2018 at 05:35:35PM +0200, Arnd Bergmann wrote:
> > > On Mon, Jul 23, 2018 at 5:23 PM, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > > > index 1b18b4722420..72c9b6778b0a 100644
> > > > --- a/arch/arm64/mm/init.c
> > > > +++ b/arch/arm64/mm/init.c
> > > > @@ -611,11 +611,13 @@ void __init mem_init(void)
> > > >         BUILD_BUG_ON(TASK_SIZE_32                       > TASK_SIZE_64);
> > > >  #endif
> > > >
> > > > +#ifndef CONFIG_SPARSEMEM_VMEMMAP
> > > >         /*
> > > 
> > > I tested it on two broken configurations, and found that you have
> > > a typo here, it should be 'ifdef', not 'ifndef'. With that change, it
> > > seems to build fine.
> > > 
> > > Tested-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > Thanks for testing it, I don't have a cross-compile toolchain set up.
> > 
> > ---
> 
> Thanks Arnd, Johannes. I can pick this up for -rc7 via the arm64 tree,
> unless it's already queued elsewhere?

I've pushed this to the arm64 for-next/fixes branch heading for -rc7.

Will
