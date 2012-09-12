From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 12 Sep 2012 16:31:29 -0400 (EDT)
Subject: [PATCH] of: specify initrd location using 64-bit
In-Reply-To: <5050EF3F.6030003@gmail.com>
References: <1347465937-7056-1-git-send-email-cyril@ti.com>
 <5050EF3F.6030003@gmail.com>
Message-ID: <alpine.LFD.2.02.1209121629260.28681@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Sep 2012, Rob Herring wrote:

> On 09/12/2012 11:05 AM, Cyril Chemparathy wrote:
> > On some PAE architectures, the entire range of physical memory could reside
> > outside the 32-bit limit.  These systems need the ability to specify the
> > initrd location using 64-bit numbers.
> > 
> > This patch globally modifies the early_init_dt_setup_initrd_arch() function to
> > use 64-bit numbers instead of the current unsigned long.
> 
> S-o-B?
> 
> > ---
> >  arch/arm/mm/init.c            |    2 +-
> >  arch/c6x/kernel/devicetree.c  |    3 +--
> >  arch/microblaze/kernel/prom.c |    3 +--
> >  arch/mips/kernel/prom.c       |    3 +--
> >  arch/openrisc/kernel/prom.c   |    3 +--
> >  arch/powerpc/kernel/prom.c    |    3 +--
> >  arch/x86/kernel/devicetree.c  |    3 +--
> >  drivers/of/fdt.c              |   10 ++++++----
> >  include/linux/of_fdt.h        |    3 +--
> >  9 files changed, 14 insertions(+), 19 deletions(-)
> > 
> > diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> > index ad722f1..579792c 100644
> > --- a/arch/arm/mm/init.c
> > +++ b/arch/arm/mm/init.c
> > @@ -76,7 +76,7 @@ static int __init parse_tag_initrd2(const struct tag *tag)
> >  __tagtable(ATAG_INITRD2, parse_tag_initrd2);
> >  
> >  #ifdef CONFIG_OF_FLATTREE
> > -void __init early_init_dt_setup_initrd_arch(unsigned long start, unsigned long end)
> > +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
> 
> phys_initrd_start/size need to change too. Not sure about similar things
> on other arches.

size ?


Nicolas
