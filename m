From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 14 Mar 2015 08:59:02 +0100
Subject: [PATCH 0/4] arm64: boot fixes/updates
In-Reply-To: <1426263277-9827-1-git-send-email-mark.rutland@arm.com>
References: <1426263277-9827-1-git-send-email-mark.rutland@arm.com>
Message-ID: <CAKv+Gu_CDJu5Wx3uEU4Qv4_d1350n0hNnQye147gH4a=Qcow_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 March 2015 at 17:14, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi all,
>
> The following patches address a few boot related issues I spotted
> recently.
>
> The first patch fixes alternatives for !SMP kernels, the second fixes a
> potential issue with boot mode detection, and the final patches give us
> some better logging of the boot mode, fixing a latent bug in mismatch
> detection (though until now this has not been a problem).
>
> Ard, Marc, I guess our recent boot patches are all going to clash. Do we
> need to sort that out between us or are we relying on the arm64
> maintainers? ;)
>

Seems we spotted and fixed the same bug at the same time :-)
(but I failed to put you on cc)

http://article.gmane.org/gmane.linux.ports.arm.kernel/400100

I can stick all of our patches on a branch for Will to pull, if people
are ok with that?
I need another couple of acks though

-- 
Ard.


> Mark Rutland (4):
>   arm64: apply alternatives for !SMP kernels
>   arm64: head.S: fix __boot_cpu_mode alignment
>   arm64: fix hyp mode mismatch detection
>   arm64: log CPU boot modes
>
>  arch/arm64/Kconfig                |  4 ++++
>  arch/arm64/include/asm/smp_plat.h |  2 ++
>  arch/arm64/kernel/head.S          |  4 ++--
>  arch/arm64/kernel/setup.c         | 25 +++++++++++++++++++++++++
>  arch/arm64/kernel/smp.c           |  2 +-
>  5 files changed, 34 insertions(+), 3 deletions(-)
>
> --
> 1.9.1
>
