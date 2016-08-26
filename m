From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Aug 2016 10:15:30 +0100
Subject: [PATCH] arm64: always enable DEBUG_RODATA and remove the Kconfig
 option
In-Reply-To: <1472142204-14258-1-git-send-email-mark.rutland@arm.com>
References: <1472142204-14258-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160826091530.GB13554@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2016 at 05:23:23PM +0100, Mark Rutland wrote:
> Follow the example set by x86 in commit 9ccaf77cf05915f5 ("x86/mm:
> Always enable CONFIG_DEBUG_RODATA and remove the Kconfig option"), and
> make these protections a fundamental security feature rather than an
> opt-in. This also results in a minor code simplification.
> 
> For those rare cases when users wish to disable this protection (e.g.
> for debugging), this can be done by passing 'rodata=off' on the command
> line.
> 
> As DEBUG_RODATA_ALIGN is only intended to address a performance/memory
> tradeoff, and does not affect correctness, this is left user-selectable.
> DEBUG_MODULE_RONX is also left user-selectable until the core code
> provides a boot-time option to disable the protection for debugging
> use-cases.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/Kconfig       |  3 +++
>  arch/arm64/Kconfig.debug | 10 ----------
>  arch/arm64/kernel/insn.c |  2 +-
>  3 files changed, 4 insertions(+), 11 deletions(-)

This is a very popular patch.

Applied for 4.9. Perhaps it makes up for all the unpopular patches I've
applied in the past.

Will
