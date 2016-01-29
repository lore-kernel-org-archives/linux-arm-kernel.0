From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Fri, 29 Jan 2016 15:39:35 +0000
Subject: [PATCH v4 20/22] efi: stub: add implementation of
 efi_random_alloc()
In-Reply-To: <1453828249-14467-21-git-send-email-ard.biesheuvel@linaro.org>
References: <1453828249-14467-1-git-send-email-ard.biesheuvel@linaro.org>
 <1453828249-14467-21-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160129153935.GB2611@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Jan, at 06:10:47PM, Ard Biesheuvel wrote:
> +
> +/*
> + * The UEFI memory descriptors have a virtual address field that is only used
> + * when installing the virtual mapping using SetVirtualAddressMap(). Since it
> + * is unused here, we can reuse it to keep track of each descriptor's slot
> + * count.
> + */
> +#define MD_NUM_SLOTS(md)	((md)->virt_addr)
> +
> +efi_status_t efi_random_alloc(efi_system_table_t *sys_table_arg,
> +			      unsigned long size,
> +			      unsigned long align,
> +			      unsigned long *addr,
> +			      unsigned long random_seed)
> +{
> +	unsigned long map_size, desc_size, total_slots = 0, target_slot;
> +	efi_status_t status = EFI_NOT_FOUND;
> +	efi_memory_desc_t *memory_map;
> +	int map_offset;

The assignment of 'status' is not needed since it gets assigned a new
value immediately.

Otherwise looks good.

Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
