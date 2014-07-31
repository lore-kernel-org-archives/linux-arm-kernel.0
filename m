From: will.deacon@arm.com (Will Deacon)
Date: Thu, 31 Jul 2014 14:19:47 +0100
Subject: [PATCH][next] arm64: KVM: GICv3: move system register access to
 msr_s/mrs_s
In-Reply-To: <1406812599-18631-1-git-send-email-marc.zyngier@arm.com>
References: <1406812599-18631-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140731131947.GT26853@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 02:16:39PM +0100, Marc Zyngier wrote:
> Commit 72c583951526 (arm64: gicv3: Allow GICv3 compilation with
> older binutils) changed the way we express the GICv3 system registers,
> but couldn't change the occurences used by KVM as the code wasn't
> merged yet.
> 
> Just fix the accessors.
> 
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> -next is currently borked. I suggest we take this patch via the kvmarm tree,
> and only send our PR once the arm64 tree has hit Linus' tree. It contains
> the same dependency on the GIC tree anyway.

I'm fine with that as long as Paulo doesn't mind waiting for the arm64 stuff
to go in first (I have no reason to delay my pull request, so shouldn't be
an issue).

If it helps:

  Acked-by: Will Deacon <will.deacon@arm.com>

I can't help but point out that we wouldn't be in this mess if you'd got
your stuff into -next sooner ;)

Will
