From: matt@console-pimps.org (Matt Fleming)
Date: Tue, 6 Aug 2013 14:53:14 +0100
Subject: [PATCH 3/7] Change EFI helper APIs to be more flexible
In-Reply-To: <1375478948-22562-4-git-send-email-roy.franz@linaro.org>
References: <1375478948-22562-1-git-send-email-roy.franz@linaro.org>
 <1375478948-22562-4-git-send-email-roy.franz@linaro.org>
Message-ID: <20130806135314.GX2515@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 02 Aug, at 02:29:04PM, Roy Franz wrote:
> * Change the EFI helper functions to be more flexible to allow their use
> by other architectures.
> * Pass system table pointer as argument to all functions that use it,
> rather than use a global variable.
> * Change name of __get_map to efi_get_memory_map, and add key pointer argument
> so it can be used to get final memory map before the EFI exitBootServices()
> function is called.
> * Change the handle_ramdisks() to handle_cmdline_files(), and make it more
> generic by taking string to match rather than hardcoding 'initrd='
> so it can be used to load device tree files as well.
> * Add 'min' address parameter to limit low_alloc() alloctions
> * Fix type of chunksize to match EFI function (not checked in x86 code
> as wrappers break type checking.)
> * rename alloc/free functions - low_free() is usable by both low_alloc()
> and high_alloc(), so rename them to be more consistent - efi_low_alloc()
> efi_high_alloc(), and efi_free()
> * Enforce minimum pagesize alignment as expected by EFI allocate_pages().
> * check for 0 size in efi_free.
 
This is way too many changes to include in a single patch, and makes
review fairly difficult. Please split this large patch into smaller
patches.

Not only are smaller patches easier to review, they make it much easier
for you to incorporate any feedback.

-- 
Matt Fleming, Intel Open Source Technology Center
