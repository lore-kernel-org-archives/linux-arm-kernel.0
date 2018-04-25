From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Apr 2018 19:07:09 +0100
Subject: [RFC PATCH 6/8] arm64/sve: Move sve_pffr() to fpsimd.h and make
 inline
In-Reply-To: <1524242802-21163-7-git-send-email-Dave.Martin@arm.com>
References: <1524242802-21163-1-git-send-email-Dave.Martin@arm.com>
 <1524242802-21163-7-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180425180709.xglcnopcoxqi6dn4@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2018 at 05:46:40PM +0100, Dave P Martin wrote:
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

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
