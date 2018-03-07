From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Mar 2018 18:09:25 +0000
Subject: [PATCH v5 01/23] arm64: alternatives: Add dynamic patching feature
In-Reply-To: <20180301155538.26860-2-marc.zyngier@arm.com>
References: <20180301155538.26860-1-marc.zyngier@arm.com>
 <20180301155538.26860-2-marc.zyngier@arm.com>
Message-ID: <20180307180925.ageajlaeqwtt4c2m@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2018 at 03:55:16PM +0000, Marc Zyngier wrote:
> We've so far relied on a patching infrastructure that only gave us
> a single alternative, without any way to provide a range of potential
> replacement instructions. For a single feature, this is an all or
> nothing thing.
> 
> It would be interesting to have a more flexible grained way of patching
> the kernel though, where we could dynamically tune the code that gets
> injected.
> 
> In order to achive this, let's introduce a new form of dynamic patching,
> assiciating a callback to a patching site. This callback gets source and
> target locations of the patching request, as well as the number of
> instructions to be patched.
> 
> Dynamic patching is declared with the new ALTERNATIVE_CB and alternative_cb
> directives:
> 
> 	asm volatile(ALTERNATIVE_CB("mov %0, #0\n", callback)
> 		     : "r" (v));
> or
> 	alternative_cb callback
> 		mov	x0, #0
> 	alternative_cb_end
> 
> where callback is the C function computing the alternative.
> 
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
