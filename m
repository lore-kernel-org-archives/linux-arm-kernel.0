From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 2 May 2013 15:38:29 +0100
Subject: [PATCH v3 19/32] arm64: KVM: Plug the VGIC
In-Reply-To: <5177C559.9070806@arm.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-20-git-send-email-marc.zyngier@arm.com>
 <20130423230012.GG20569@gmail.com> <5177C559.9070806@arm.com>
Message-ID: <20130502143828.GE20730@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 12:43:21PM +0100, Marc Zyngier wrote:
> On 24/04/13 00:00, Christoffer Dall wrote:
> > On Mon, Apr 08, 2013 at 05:17:21PM +0100, Marc Zyngier wrote:
> >> Add support for the in-kernel GIC emulation. The include file
> >> is a complete duplicate of the 32bit one - something to fix
> >> at one point.
> > 
> > seems like something that should be fixed sooner as opposed to later...
> > Is it hard?
> 
> Hard? No. Disgusting? Yes.
> 
> You need to find a common location for the files. Something like
> virt/kvm/arm/vgic.h? The x86/ia64 guys already have virt/kvm/ioapic.h as
> a (bad) precedent.

Probably not that bad, we already have include/linux/irqchip/arm-gic.h,
so you could add virt/kvm/arm-vgic.[ch] (or create an arm subdirectory
so there will be a tendency to move a lot more in there).

-- 
Catalin
