From: panand@redhat.com (Pratyush Anand)
Date: Fri, 27 May 2016 17:08:31 +0530
Subject: [PATCH kexec-tools 32/32] arm: report which ELF core format we
 will use
In-Reply-To: <E1axXUb-0004k4-LW@e0050434b2927.dyn.arm.linux.org.uk>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
 <E1axXUb-0004k4-LW@e0050434b2927.dyn.arm.linux.org.uk>
Message-ID: <CAHB_Guq8Q965VgCzp+Spa2J_u5cUOFifgD45xOYR2uR-P4BxhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 3, 2016 at 3:53 PM, Russell King <rmk@arm.linux.org.uk> wrote:
> Report which ELF core format will be used to create the template ELF
> core dump in the debug information.
>
> Signed-off-by: Russell King <rmk@arm.linux.org.uk>

Reviewed-by: Pratyush Anand <panand@redhat.com>

> ---
>  kexec/arch/arm/crashdump-arm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
> index 3b71267..4a89b5e 100644
> --- a/kexec/arch/arm/crashdump-arm.c
> +++ b/kexec/arch/arm/crashdump-arm.c
> @@ -315,6 +315,8 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
>                 last_ranges = 0;
>
>         if (crash_memory_ranges[last_ranges].end > UINT32_MAX) {
> +               dbgprintf("Using 64-bit ELF core format\n");
> +
>                 /* for support LPAE enabled kernel*/
>                 elf_info.class = ELFCLASS64;
>
> @@ -323,6 +325,7 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
>                                          usablemem_rgns.size, &buf, &bufsz,
>                                          ELF_CORE_HEADER_ALIGN);
>         } else {
> +               dbgprintf("Using 32-bit ELF core format\n");
>                 err = crash_create_elf32_headers(info, &elf_info,
>                                          usablemem_rgns.ranges,
>                                          usablemem_rgns.size, &buf, &bufsz,
> --
> 1.9.1
>
