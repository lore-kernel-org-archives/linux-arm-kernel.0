From: dianders@chromium.org (Doug Anderson)
Date: Thu, 24 Apr 2014 17:52:51 -0700
Subject: [PATCH 1/2] arm: fixmap: implement __set_fixmap()
In-Reply-To: <1396646870-29695-1-git-send-email-rabin@rab.in>
References: <1396646870-29695-1-git-send-email-rabin@rab.in>
Message-ID: <CAD=FV=UuYpc-kFMymy7P_mL+iYziKqJii8=32P6kMELDFnC1pQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rabin,

On Fri, Apr 4, 2014 at 2:27 PM, Rabin Vincent <rabin@rab.in> wrote:
> This is used from set_fixmap() and clear_fixmap() via
> asm-generic/fixmap.h.
>
> Signed-off-by: Rabin Vincent <rabin@rab.in>
> ---
> Needs "arm: use generic fixmap.h", available in linux-next.
>
>  arch/arm/include/asm/fixmap.h | 2 ++
>  arch/arm/mm/mmu.c             | 7 +++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
> index 68ea615..55ed076 100644
> --- a/arch/arm/include/asm/fixmap.h
> +++ b/arch/arm/include/asm/fixmap.h
> @@ -23,6 +23,8 @@ enum fixed_addresses {
>         __end_of_fixed_addresses
>  };
>
> +void __set_fixmap(enum fixed_addresses idx, unsigned long phys, pgprot_t prot);

nit: I think you should use phys_addr_t for the physical address, right?

void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot);


...I'm no expert at fixmap, but otherwise this looks pretty reasonable to me.

-Doug
