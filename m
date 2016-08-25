From: keescook@chromium.org (Kees Cook)
Date: Thu, 25 Aug 2016 14:16:11 -0400
Subject: [PATCH] arm64: always enable DEBUG_RODATA and remove the Kconfig
 option
In-Reply-To: <1472142204-14258-1-git-send-email-mark.rutland@arm.com>
References: <1472142204-14258-1-git-send-email-mark.rutland@arm.com>
Message-ID: <CAGXu5jJCppekxa4KpWUj7yr5wFcZ-0YeA3gbYaqnNEdKeE7iJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 25, 2016 at 12:23 PM, Mark Rutland <mark.rutland@arm.com> wrote:
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

Awesome!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Nexus Security
