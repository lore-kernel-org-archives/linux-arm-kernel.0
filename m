From: Steve.Capper@arm.com (Steve Capper)
Date: Mon, 26 Nov 2018 12:11:16 +0000
Subject: [PATCH V3 1/5] mm: mmap: Allow for "high" userspace addresses
In-Reply-To: <20181123181744.GK3360@arrakis.emea.arm.com>
References: <20181114133920.7134-1-steve.capper@arm.com>
 <20181114133920.7134-2-steve.capper@arm.com>
 <20181123181744.GK3360@arrakis.emea.arm.com>
Message-ID: <20181126121100.GA2012@capper-debian.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2018 at 06:17:44PM +0000, Catalin Marinas wrote:
> On Wed, Nov 14, 2018 at 01:39:16PM +0000, Steve Capper wrote:
> > This patch adds support for "high" userspace addresses that are
> > optionally supported on the system and have to be requested via a hint
> > mechanism ("high" addr parameter to mmap).
> > 
> > Architectures such as powerpc and x86 achieve this by making changes to
> > their architectural versions of arch_get_unmapped_* functions. However,
> > on arm64 we use the generic versions of these functions.
> > 
> > Rather than duplicate the generic arch_get_unmapped_* implementations
> > for arm64, this patch instead introduces two architectural helper macros
> > and applies them to arch_get_unmapped_*:
> >  arch_get_mmap_end(addr) - get mmap upper limit depending on addr hint
> >  arch_get_mmap_base(addr, base) - get mmap_base depending on addr hint
> > 
> > If these macros are not defined in architectural code then they default
> > to (TASK_SIZE) and (base) so should not introduce any behavioural
> > changes to architectures that do not define them.
> > 
> > Signed-off-by: Steve Capper <steve.capper@arm.com>
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!
