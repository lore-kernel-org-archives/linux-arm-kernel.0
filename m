From: will.deacon@arm.com (Will Deacon)
Date: Wed, 27 Mar 2013 12:20:17 +0000
Subject: [PATCH 3/4] ARM: mm: kill unused TLB_CAN_READ_FROM_L1_CACHE and
 use ALT_SMP instead
In-Reply-To: <20130327105348.GD801@MacBook-Pro.local>
References: <1364235581-17900-1-git-send-email-will.deacon@arm.com>
 <1364235581-17900-4-git-send-email-will.deacon@arm.com>
 <20130327105348.GD801@MacBook-Pro.local>
Message-ID: <20130327122017.GA18429@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 10:53:49AM +0000, Catalin Marinas wrote:
> On Mon, Mar 25, 2013 at 06:19:40PM +0000, Will Deacon wrote:
> > Many ARMv7 cores have hardware page table walkers that can read the L1
> > cache. This is discoverable from the ID_MMFR3 register, although this
> > can be expensive to access from the low-level set_pte functions and is a
> > pain to cache, particularly with multi-cluster systems.
> > 
> > A useful observation is that the multi-processing extensions for ARMv7
> > require coherent table walks, meaning that we can make use of ALT_SMP
> > patching in proc-v7-* to patch away the cache flush safely for these
> > cores.
> > 
> > Reported-by: Albin Tonnerre <Albin.Tonnerre@arm.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> There are some pmd flushing functions we should target as well
> (flush_pmd_entry, clean_pmd_entry) in this patch or a new one.

I already took care of those by avoiding the TLB_DCLEAN flag for v7 SMP.

Will
