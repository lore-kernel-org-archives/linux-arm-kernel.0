From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 9 May 2018 09:46:05 +0100
Subject: [PATCH v6 10/15] arm64/sve: Move sve_pffr() to fpsimd.h and make
 inline
In-Reply-To: <1525797900-5548-11-git-send-email-Dave.Martin@arm.com>
References: <1525797900-5548-1-git-send-email-Dave.Martin@arm.com>
 <1525797900-5548-11-git-send-email-Dave.Martin@arm.com>
Message-ID: <c98bc032-3120-974e-2511-e909a289584d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/18 17:44, Dave Martin wrote:
> In order to make sve_save_state()/sve_load_state() more easily
> reusable and to get rid of a potential branch on context switch
> critical paths, this patch makes sve_pffr() inline and moves it to
> fpsimd.h.
> 
> <asm/processor.h> must be included in fpsimd.h in order to make
> this work, and this creates an #include cycle that is tricky to
> avoid without modifying core code, due to the way the PR_SVE_*()
> prctl helpers are included in the core prctl implementation.
> 
> Instead of breaking the cycle, this patch defers inclusion of
> <asm/fpsimd.h> in <asm/processor.h> until the point where it is
> actually needed: i.e., immediately before the prctl definitions.
> 
> No functional change.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
