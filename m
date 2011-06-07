From: will.deacon@arm.com (Will Deacon)
Date: Tue, 7 Jun 2011 17:22:04 +0100
Subject: [PATCH 06/11] ARM: cortex-a5: add HWCAP_VFPv4D16 to proc info
	structure
In-Reply-To: <20110607161736.GB19855@arm.com>
References: <1307379355-13802-1-git-send-email-will.deacon@arm.com>
	<1307379355-13802-7-git-send-email-will.deacon@arm.com>
	<20110607161736.GB19855@arm.com>
Message-ID: <20110607162204.GC12639@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2011 at 05:17:36PM +0100, Dave Martin wrote:
> On Mon, Jun 06, 2011 at 05:55:50PM +0100, Will Deacon wrote:
> > The Cortex-A5 implements VFPv4D16, so add this to the hwcaps for this
> > processor.
> > 
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> >  arch/arm/mm/proc-v7.S |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> > index b22d98d..8eba506 100644
> > --- a/arch/arm/mm/proc-v7.S
> > +++ b/arch/arm/mm/proc-v7.S
> > @@ -466,7 +466,7 @@ cpu_elf_name:
> >  __v7_ca5mp_proc_info:
> >  	.long	0x410fc050
> >  	.long	0xff0ffff0
> > -	__v7_proc __v7_ca5mp_setup
> > +	__v7_proc __v7_ca5mp_setup, HWCAP_VFPv4D16
> 
> Is VFPv4 a superset of VFPv3?  If so, should we also include
> HWCAP_VFPv3D16 (and what about HWCAP_VFP)?
>

Actually, it looks like this shouldn't be declared statically at all, since the
kernel have not have VFP support compiled in. Rather, the vfp code will detect
the capability and adjust elf_hwcap at runtime.

Will
