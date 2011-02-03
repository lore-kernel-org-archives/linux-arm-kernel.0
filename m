From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 03 Feb 2011 17:13:49 +0000
Subject: [PATCH v4 06/19] ARM: LPAE: Add (pte|pmd|pgd|pgprot)val_t type
	definitions as u32
In-Reply-To: <1295891761-18366-7-git-send-email-catalin.marinas@arm.com>
References: <1295891761-18366-1-git-send-email-catalin.marinas@arm.com>
	<1295891761-18366-7-git-send-email-catalin.marinas@arm.com>
Message-ID: <1296753229.28466.20.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-01-24 at 17:55 +0000, Catalin Marinas wrote:
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -290,7 +290,7 @@ static void __init build_mem_type_table(void)
>  {
>         struct cachepolicy *cp;
>         unsigned int cr = get_cr();
> -       unsigned int user_pgprot, kern_pgprot, vecs_pgprot;
> +       pgprotval_t user_pgprot, kern_pgprot, vecs_pgprot;
>         int cpu_arch = cpu_architecture();
>         int i;

I have an additional hunk for this file as pmd's have are 64-bit long
with LPAE (fixup pushed to the arm-lpae branch):

@@ -62,7 +62,7 @@ EXPORT_SYMBOL(pgprot_kernel);
 struct cachepolicy {
 	const char	policy[16];
 	unsigned int	cr_mask;
-	unsigned int	pmd;
+	pmdval_t	pmd;
 	pteval_t	pte;
 }; 

-- 
Catalin
