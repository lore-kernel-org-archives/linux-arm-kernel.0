From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Aug 2016 16:11:35 +0100
Subject: [PATCH] ARM: mm: pull asm/memory.h explicitly
In-Reply-To: <57B5C6FD.1090104@arm.com>
References: <1471450634-45566-1-git-send-email-vladimir.murzin@arm.com>
 <20160818142246.GW1041@n2100.armlinux.org.uk>
 <57B5C6FD.1090104@arm.com>
Message-ID: <20160818151135.GC1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2016 at 03:32:29PM +0100, Vladimir Murzin wrote:
> On 18/08/16 15:22, Russell King - ARM Linux wrote:
> > On Wed, Aug 17, 2016 at 05:17:14PM +0100, Vladimir Murzin wrote:
> >> Commit d78114554939a (""ARM: 8512/1: proc-v7.S: Adjust stack address when
> >> XIP_KERNEL"") introduced a macro which lives under asm/memory.h.
> >> Unfortunately, for MMU-less systems (like R-class) it leads to build failure:
> >>
> >> arch/arm/mm/proc-v7.S: Assembler messages:
> >> arch/arm/mm/proc-v7.S:538: Error: unrecognised relocation suffix
> >> make[1]: *** [arch/arm/mm/proc-v7.o] Error 1
> >> make: *** [arch/arm/mm] Error 2
> >>
> >> since it is implicitly pulled via asm/pgtable.h for MMU capable systems only.
> >>
> >> To fix it include asm/memory.h explicitly.
> >>
> >> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> > 
> > Looks fine, thanks.
> > 
> 
> Should I drop it into patch system?

Yes please.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
