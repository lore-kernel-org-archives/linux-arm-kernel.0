From: bp@suse.de (Borislav Petkov)
Date: Tue, 17 Oct 2017 18:43:36 +0200
Subject: [PATCH v5 1/2] acpi: apei: remove the unused dead-code for
 SEA/NMI notification type
In-Reply-To: <1508227341-15651-1-git-send-email-gengdongjiu@huawei.com>
References: <1508227341-15651-1-git-send-email-gengdongjiu@huawei.com>
Message-ID: <20171017164336.cedso3f35lpeam7f@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 04:02:20PM +0800, Dongjiu Geng wrote:
> @@ -1061,23 +1052,9 @@ static void ghes_nmi_init_cxt(void)
>  	init_irq_work(&ghes_proc_irq_work, ghes_proc_in_irq);
>  }
>  #else /* CONFIG_HAVE_ACPI_APEI_NMI */
> -static inline void ghes_nmi_add(struct ghes *ghes)
> -{
> -	pr_err(GHES_PFX "ID: %d, trying to add NMI notification which is not supported!\n",
> -	       ghes->generic->header.source_id);
> -	BUG();
> -}
> -
> -static inline void ghes_nmi_remove(struct ghes *ghes)
> -{
> -	pr_err(GHES_PFX "ID: %d, trying to remove NMI notification which is not supported!\n",
> -	       ghes->generic->header.source_id);
> -	BUG();
> -}
> -

So GHES NMI notification method is x86-only AFAIK and HAVE_ACPI_APEI_NMI
is selected only on x86. Why are you removing those guards? Does ARM
have ACPI_HEST_NOTIFY_NMI notification type now too?

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton, HRB 21284 (AG N?rnberg)
-- 
