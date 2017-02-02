From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Thu, 2 Feb 2017 21:34:29 +0000
Subject: [PATCH 4/7] efi: Get the secure boot status [ver #7]
In-Reply-To: <148587562967.4026.18171897997650345605.stgit@warthog.procyon.org.uk>
References: <148587558696.4026.16034622623568539004.stgit@warthog.procyon.org.uk>
 <148587562967.4026.18171897997650345605.stgit@warthog.procyon.org.uk>
Message-ID: <20170202213429.GP31613@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 31 Jan, at 03:13:49PM, David Howells wrote:
> diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
> index f99978db6b6f..57c2c9c71e53 100644
> --- a/arch/x86/boot/compressed/eboot.c
> +++ b/arch/x86/boot/compressed/eboot.c
> @@ -988,6 +988,12 @@ struct boot_params *efi_main(struct efi_config *c,
>  	else
>  		setup_boot_services32(efi_early);
>  
> +	/* If the boot loader gave us a value for secure_boot then we use that,
> +	 * otherwise we ask the BIOS.
> +	 */
> +	if (boot_params->secure_boot == efi_secureboot_mode_unset)
> +		boot_params->secure_boot = efi_get_secureboot(sys_table);
> +
>  	setup_graphics(boot_params);
>  
>  	setup_efi_pci(boot_params);

It's not a big deal, but this multi-line comment format isn't correct.
Either Ard or I will fix it up when applying this patch. Same goes for
the comment in patch 5.

Otherwise this patch looks fine.
