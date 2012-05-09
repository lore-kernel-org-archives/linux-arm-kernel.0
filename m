From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 09 May 2012 21:36:43 +0200
Subject: [PATCH v2] ARM: DT: Add binding for GIC virtualization extentions
 (VGIC)
In-Reply-To: <201205091921.43299.arnd@arndb.de>
References: <1336586277-28454-1-git-send-email-marc.zyngier@arm.com>
 <201205091921.43299.arnd@arndb.de>
Message-ID: <a226ca6e8dd0370afeeb9aa1d67ddfde@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 May 2012 19:21:42 +0000, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 09 May 2012, Marc Zyngier wrote:
>> 
>> The GICv2 can have virtualization extension support, consisting
>> of an additional set of registers and interrupts. Add the necessary
>> binding to the GIC DT documentation.
>> 
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Would it make sense to add a way to detect whether a GIC is virtual
> or real? Maybe an optional empty "virtual-gic" property or an additional
> "compatible" value. Even if we don't need it now, it might come in handy
> if we require it already.

I don't really see a need for this. When running on a virtual machine, the
kernel cannot tell if this is the real thing or not (the virtual CPU
interface looks exactly like the normal one once mapped into the guest
address space).

Or maybe I just didn't get your use case?

        M.
-- 
Fast, cheap, reliable. Pick two.
