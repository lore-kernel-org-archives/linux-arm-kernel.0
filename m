From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Mar 2015 14:51:02 +0000
Subject: [PATCH 5/5] mm: fold arch_randomize_brk into
 ARCH_HAS_ELF_RANDOMIZE
In-Reply-To: <1425341988-1599-6-git-send-email-keescook@chromium.org>
References: <1425341988-1599-1-git-send-email-keescook@chromium.org>
 <1425341988-1599-6-git-send-email-keescook@chromium.org>
Message-ID: <20150309145101.GO8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 04:19:48PM -0800, Kees Cook wrote:
> diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
> index afb9cafd3786..c1ff8ab12914 100644
> --- a/arch/arm/include/asm/elf.h
> +++ b/arch/arm/include/asm/elf.h
> @@ -125,10 +125,6 @@ int dump_task_regs(struct task_struct *t, elf_gregset_t *elfregs);
>  extern void elf_set_personality(const struct elf32_hdr *);
>  #define SET_PERSONALITY(ex)	elf_set_personality(&(ex))
>  
> -struct mm_struct;
> -extern unsigned long arch_randomize_brk(struct mm_struct *mm);
> -#define arch_randomize_brk arch_randomize_brk
> -
>  #ifdef CONFIG_MMU
>  #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
>  struct linux_binprm;

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
