From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 18 Jun 2010 14:55:38 +0400
Subject: [PATCH 1/5] [ARM] implement arch_randomize_brk()
In-Reply-To: <1276720403-27918-2-git-send-email-nico@fluxnic.net>
References: <1276720403-27918-1-git-send-email-nico@fluxnic.net>
	<1276720403-27918-2-git-send-email-nico@fluxnic.net>
Message-ID: <4C1B50AA.9050507@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Nicolas Pitre wrote:

> For this feature to take effect, CONFIG_COMPAT_BRK must be turned
> off.  This can safely be turned off for any EABI user space versions.

> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
[...]
> diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
> index 51662fe..0a96e8c 100644
> --- a/arch/arm/include/asm/elf.h
> +++ b/arch/arm/include/asm/elf.h
> @@ -121,4 +121,7 @@ int dump_task_regs(struct task_struct *t, elf_gregset_t *elfregs);
>  extern void elf_set_personality(const struct elf32_hdr *);
>  #define SET_PERSONALITY(ex)	elf_set_personality(&(ex))
>  
> +extern unsigned long arch_randomize_brk(struct mm_struct *mm);
> +#define arch_randomize_brk arch_randomize_brk

    Isn't this an "infinitely recursive" macro?

WBR, Sergei
