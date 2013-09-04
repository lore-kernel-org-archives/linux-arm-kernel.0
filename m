From: mohun106@gmail.com (Radha Mohan)
Date: Wed, 4 Sep 2013 18:22:44 +0530
Subject: [PATCH 1/1] arm64: Align an assembler string properly
In-Reply-To: <CAC8NTUWvEYpugbUfZ3A54zFbS71mnChfCk2sVKUxxxWAHz+nRw@mail.gmail.com>
References: <CAC8NTUWvEYpugbUfZ3A54zFbS71mnChfCk2sVKUxxxWAHz+nRw@mail.gmail.com>
Message-ID: <CAC8NTUUdpUxfzn4_nrvMxj_otGmXROEKwio7DQ27BoMv0vwsAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,
Can you please review this?

regards,
Radha Mohan

On Mon, Sep 2, 2013 at 4:18 PM, Radha Mohan <mohun106@gmail.com> wrote:
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
>
>  /*
> --
> 1.7.1
