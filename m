From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 2 Sep 2013 12:28:27 +0100
Subject: [PATCH 1/1] arm64: Align an assembler string properly
In-Reply-To: <CAC8NTUWvEYpugbUfZ3A54zFbS71mnChfCk2sVKUxxxWAHz+nRw@mail.gmail.com>
References: <CAC8NTUWvEYpugbUfZ3A54zFbS71mnChfCk2sVKUxxxWAHz+nRw@mail.gmail.com>
Message-ID: <20130902112827.GG64064@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 02, 2013 at 11:48:02AM +0100, Radha Mohan wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> Do a proper align and put it in the right section.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>  arch/arm64/mm/proc.S |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 76d8320..1f89adc 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -95,10 +95,11 @@ ENTRY(cpu_do_switch_mm)
>         ret
>  ENDPROC(cpu_do_switch_mm)
> 
> +       .section ".rodata"
>  cpu_name:
>         .ascii  "AArch64 Processor"
> -       .align
> 
> +       .align 3
>         .section ".text.init", #alloc, #execinstr

Oh, we still have this in proc.S. I moved it long time ago to
arch/arm64/kernel/cputable.c but forgot about this. It compiles fine
after removing it completely.

-- 
Catalin
