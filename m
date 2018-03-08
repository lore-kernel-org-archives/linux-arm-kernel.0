From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 8 Mar 2018 13:59:02 +0000
Subject: [PATCH v5 18/23] arm64: KVM: Add epilogue branching to the
 vector code
In-Reply-To: <20180301155538.26860-19-marc.zyngier@arm.com>
References: <20180301155538.26860-1-marc.zyngier@arm.com>
 <20180301155538.26860-19-marc.zyngier@arm.com>
Message-ID: <20180308135902.olhvrydbcszjl3ap@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 03:55:33PM +0000, Marc Zyngier wrote:
> We are soon going to have to do some extra work in the BP hardening
> vector slots. Instead of doing that work in the vectors themselves
> (which would massively reduce the space available to deal with
> Spectre v2), let's branch to an epilogue where we can do "stuff".
> 
> This has a number of consequences:
> - We need some free registers, so we're spilling x0 and x1 on the
>   stack
> - In order to counterbalance this, we branch to the *second* instruction
>   in the vectors, avoiding the initial store that is already there
>   (or loading the registers back if we've branched to a panic vector)
> 
> This is all controlled by a new capability (ARM64_HARDEN_EL2_VECTORS)
> which doesn't get enabled yet.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

That's mostly kvm but anyway:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
