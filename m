From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 30 Nov 2011 11:29:32 +0000
Subject: [PATCH v2 1/6] ARM: idmap: populate identity map pgd at init time
 using .init.text
In-Reply-To: <1322504937-24718-2-git-send-email-will.deacon@arm.com>
References: <1322504937-24718-1-git-send-email-will.deacon@arm.com>
 <1322504937-24718-2-git-send-email-will.deacon@arm.com>
Message-ID: <CAHkRjk56ep218vXC=Qvh+HRJrOGi+Dt2+7ErPieyn3=2j7SJAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 November 2011 18:28, Will Deacon <will.deacon@arm.com> wrote:
> When disabling and re-enabling the MMU, it is necessary to take out an
> identity mapping for the code that manipulates the SCTLR in order to
> avoid it disappearing from under our feet. This is useful when soft
> rebooting and returning from CPU suspend.
>
> This patch allocates a set of page tables during boot and populates them
> with an identity mapping for the .idmap.text section. This means that
> users of the identity map do not need to manage their own pgd and can
> instead annotate their functions with __idmap or, in the case of assembly
> code, place them in the correct section.
>
> Acked-by: Dave Martin <dave.martin@linaro.org>
> Tested-by: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
