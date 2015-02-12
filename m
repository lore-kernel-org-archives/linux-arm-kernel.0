From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 12 Feb 2015 19:27:39 +0800
Subject: [PATCH 0/2] arm/arm64: Detect Xen support earlier
In-Reply-To: <1423722898-16110-1-git-send-email-julien.grall@linaro.org>
References: <1423722898-16110-1-git-send-email-julien.grall@linaro.org>
Message-ID: <CAKv+Gu--9giBy-5zgg++de+LYkPfE_f7iaVB5xe-pB_QFNPCQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 February 2015 at 14:34, Julien Grall <julien.grall@linaro.org> wrote:
> Hello,
>
> This small patch series move the detection of running on Xen earlier. This is
> required in order to support earlyprintk via Xen and selecting the preferred
> console.
>
> Ard, the patch to move the call earlier (see #2) differed from the one I sent
> you privately mostly because it's not possible to translate an IRQ before the
> GIC has been initialized.
>
> Let me know if it works for you.
>

I have tested these patches with my preferred console patch on top,
and it results in console output without having to pass 'console=hvc0'
on the command line.

I didn't check anything else, nor do I have enough of a clue about Xen
to notice anything else out of the ordinary

So FWIW,

Tested-by: Ard Biesheuvel <ard@linaro.org>


> Sincerely yours,
>
> Julien Grall (1):
>   arm/xen: Correctly check if the event channel interrupt is present
>
> Stefano Stabellini (1):
>   arm,arm64/xen: move Xen initialization earlier
>
>  arch/arm/include/asm/xen/hypervisor.h |  8 +++++
>  arch/arm/kernel/setup.c               |  2 ++
>  arch/arm/xen/enlighten.c              | 58 +++++++++++++++++++++--------------
>  arch/arm64/kernel/setup.c             |  2 ++
>  4 files changed, 47 insertions(+), 23 deletions(-)
>
> --
> 2.1.0
>
