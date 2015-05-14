From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 14 May 2015 13:53:55 +0200
Subject: [PATCH v3 5/5] arm64: KVM: Switch vgic save/restore to
 alternative_insn
In-Reply-To: <1427461765-14462-6-git-send-email-marc.zyngier@arm.com>
References: <1427461765-14462-1-git-send-email-marc.zyngier@arm.com>
 <1427461765-14462-6-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150514115355.GT32765@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 27, 2015 at 01:09:25PM +0000, Marc Zyngier wrote:
> So far, we configured the world-switch by having a small array
> of pointers to the save and restore functions, depending on the
> GIC used on the platform.
> 
> Loading these values each time is a bit silly (they never change),
> and it makes sense to rely on the instruction patching instead.
> 
> This leads to a nice cleanup of the code.
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

I gave this a quick spin on Juno as well and works as expected:

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
