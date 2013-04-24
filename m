From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 24 Apr 2013 12:43:21 +0100
Subject: [PATCH v3 19/32] arm64: KVM: Plug the VGIC
In-Reply-To: <20130423230012.GG20569@gmail.com>
References: <1365437854-30214-1-git-send-email-marc.zyngier@arm.com>
 <1365437854-30214-20-git-send-email-marc.zyngier@arm.com>
 <20130423230012.GG20569@gmail.com>
Message-ID: <5177C559.9070806@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/04/13 00:00, Christoffer Dall wrote:
> On Mon, Apr 08, 2013 at 05:17:21PM +0100, Marc Zyngier wrote:
>> Add support for the in-kernel GIC emulation. The include file
>> is a complete duplicate of the 32bit one - something to fix
>> at one point.
> 
> seems like something that should be fixed sooner as opposed to later...
> Is it hard?

Hard? No. Disgusting? Yes.

You need to find a common location for the files. Something like
virt/kvm/arm/vgic.h? The x86/ia64 guys already have virt/kvm/ioapic.h as
a (bad) precedent.

While your at it, you could put a lot of the common code there as well.

	M.
-- 
Jazz is not dead. It just smells funny...
