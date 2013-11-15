From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 15 Nov 2013 14:58:44 +0000
Subject: [PATCH 1/6] arm64: mm: Add __virt_to_idmap() to keep kvm build
 happy
In-Reply-To: <528635F6.6030207@ti.com>
References: <y> <1384457866-16135-1-git-send-email-santosh.shilimkar@ti.com>
 <1384457866-16135-2-git-send-email-santosh.shilimkar@ti.com>
 <20131115133428.GA1217@darko.cambridge.arm.com>
 <528635F6.6030207@ti.com>
Message-ID: <20131115145844.GC11347@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 02:55:50PM +0000, Santosh Shilimkar wrote:
> On Friday 15 November 2013 08:34 AM, Catalin Marinas wrote:
> > On Thu, Nov 14, 2013 at 07:37:41PM +0000, Santosh Shilimkar wrote:
> >>  /*
> >> + * Added to keep arm64 kvm build working which shares code with
> >> + * 32bit port. ARM kvm code makes use of __virt_to_idmap() on arm32
> >> + * machines as hardware interconnect supported alias of physical
> >> + * memory for idmap purposes.
> >> + */
> >> +#define virt_to_idmap(x)	__virt_to_phys(x)
> > 
> > There are consistency issues with the use of underscores before
> > __virt_to_idmap. And I think you can simply say something like "Required
> > by ARM KVM code". The explanation on why really belongs to the 32-bit
> > arm code.
> > 
> Will update the comment as you suggested. Do you want me to rename the
> macros as well. I need to do update some more code for that.

The macro name should be whatever is in arch/arm/ but the comment and
the macro disagree here.

-- 
Catalin
