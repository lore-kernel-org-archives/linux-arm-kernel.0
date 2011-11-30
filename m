From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 30 Nov 2011 11:31:13 +0000
Subject: [PATCH v2 4/6] ARM: idmap: use idmap_pgd when setting up mm for
 reboot
In-Reply-To: <1322504937-24718-5-git-send-email-will.deacon@arm.com>
References: <1322504937-24718-1-git-send-email-will.deacon@arm.com>
 <1322504937-24718-5-git-send-email-will.deacon@arm.com>
Message-ID: <CAHkRjk7gCk-cuadAYLBrxwUu0TQkXSOh3iaDa3kLJsHnT=h_4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 November 2011 18:28, Will Deacon <will.deacon@arm.com> wrote:
> For soft-rebooting a system, it is necessary to map the MMU-off code
> with an identity mapping so that execution can continue safely once the
> MMU has been switched off.
>
> Currently, switch_mm_for_reboot takes out a 1:1 mapping from 0x0 to
> TASK_SIZE during reboot in the hope that the reset code lives at a
> physical address corresponding to a userspace virtual address.
>
> This patch modifies the code so that we switch to the idmap_pgd tables,
> which contain a 1:1 mapping of the cpu_reset code. This has the
> advantage of only remapping the code that we need and also means we
> don't need to worry about allocating a pgd from an atomic context in the
> case that the physical address of the cpu_reset code aliases with the
> virtual space used by the kernel.
>
> Acked-by: Dave Martin <dave.martin@linaro.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
