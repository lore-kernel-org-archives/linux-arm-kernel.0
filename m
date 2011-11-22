From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 22 Nov 2011 13:42:22 +0000
Subject: [PATCH v6 1/5] ARM: lib: add call_with_stack function for safely
 changing stack
In-Reply-To: <1321466057-19721-2-git-send-email-will.deacon@arm.com>
References: <1321466057-19721-1-git-send-email-will.deacon@arm.com>
 <1321466057-19721-2-git-send-email-will.deacon@arm.com>
Message-ID: <CAHkRjk7J=hiR3c1JH-sScGb58fY-6CJ+RH7_aF+SSZQW3vYWZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 November 2011 17:54, Will Deacon <will.deacon@arm.com> wrote:
> When disabling the MMU, it is necessary to take out a 1:1 identity map
> of the reset code so that it can safely be executed with and without
> the MMU active. To avoid the situation where the physical address of the
> reset code aliases with the virtual address of the active stack (which
> cannot be included in the 1:1 mapping), it is desirable to change to a
> new stack at a location which is less likely to alias.
>
> This code adds a new lib function, call_with_stack:
>
> ? ? ? ?void call_with_stack(void (*fn)(void *), void *arg, void *sp);
>
> which changes the stack to point at the sp parameter, before invoking
> fn(arg) with the new stack selected.
>
> Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
