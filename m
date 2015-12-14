From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 14 Dec 2015 17:07:25 +0000
Subject: [PATCH] arm64: Add missing linux/bug.h include in asm/pgtable.h
In-Reply-To: <566EF28B.7060909@arm.com>
References: <1450109244-20122-1-git-send-email-julien.grall@citrix.com>
 <20151214162242.GA27918@e104818-lin.cambridge.arm.com>
 <566EEDC8.1050501@citrix.com>
 <20151214163840.GB27918@e104818-lin.cambridge.arm.com>
 <566EF28B.7060909@arm.com>
Message-ID: <20151214170725.GC27918@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 04:47:07PM +0000, James Morse wrote:
> On 14/12/15 16:38, Catalin Marinas wrote:
> > On Mon, Dec 14, 2015 at 04:26:48PM +0000, Julien Grall wrote:
> >> On 14/12/15 16:22, Catalin Marinas wrote:
> >>> On Mon, Dec 14, 2015 at 04:07:24PM +0000, Julien Grall wrote:
> >>>> Linux 4.4-rc5 doesn't build for arm64 with CONFIG_XEN=y enabled:
> >>>>
> >>>> In file included from linux/arch/arm64/include/asm/pgtable.h:60:0,
> >>>>                  from linux/arch/arm64/include/../../arm/include/asm/xen/page.h:5,
> >>>>                  from linux/arch/arm64/include/asm/xen/page.h:1,
> >>>>                  from linux/include/xen/page.h:28,
> >>>>                  from linux/arch/arm64/xen/../../arm/xen/grant-table.c:33:
> >>>> linux/arch/arm64/include/asm/pgtable.h: In function 'set_pte_at':
> >>>> linux/include/linux/mmdebug.h:49:39: error: implicit declaration of function 'BUILD_BUG_ON_INVALID' [-Werror=implicit-function-declaration]
> >>>>  #define VM_WARN_ONCE(cond, format...) BUILD_BUG_ON_INVALID(cond)
> >>>>                                        ^
> >>>> linux/arch/arm64/include/asm/pgtable.h:281:3: note: in expansion of macro 'VM_WARN_ONCE'
> >>>>    VM_WARN_ONCE(!pte_young(pte),
> 
> I got bitten by this this morning, and had a patch to mmdebug.h I just
> sent to the linux-mm list... sorry I should have copied everyone on this
> thread (you don't get enough email already!).

If they take the mmdebug.h patch, it's even better. Please let us know
how that goes.

Thanks.

-- 
Catalin
