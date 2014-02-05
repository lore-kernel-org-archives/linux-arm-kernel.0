From: joe@perches.com (Joe Perches)
Date: Wed, 05 Feb 2014 09:34:13 -0800
Subject: [PATCH 05/22] Add shared printk wrapper for consistent prefixing
In-Reply-To: <1391619853-10601-6-git-send-email-leif.lindholm@linaro.org>
References: <1391619853-10601-1-git-send-email-leif.lindholm@linaro.org>
 <1391619853-10601-6-git-send-email-leif.lindholm@linaro.org>
Message-ID: <1391621653.30094.11.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-02-05 at 17:03 +0000, Leif Lindholm wrote:
> From: Roy Franz <roy.franz@linaro.org>
> 
> Add a wrapper for printk to standardize the prefix for informational and
> error messages from the EFI stub.

trivia:

> diff --git a/drivers/firmware/efi/efi-stub-helper.c b/drivers/firmware/efi/efi-stub-helper.c
[]
> @@ -45,6 +45,9 @@ static void efi_printk(efi_system_table_t *sys_table_arg, char *str)
>  	}
>  }
>  
> +#define pr_efi(sys_table, msg)     efi_printk(sys_table, "EFI stub: "msg)
> +#define pr_efi_err(sys_table, msg) efi_printk(sys_table, "EFI stub: ERROR: "msg)

Perhaps it'd be better to use a space after the second "

Also, maybe pr_efi should be pr_efi_info.
That would quiet any checkpatch noise around long msg uses.
