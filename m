From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 30 Aug 2013 14:31:38 +0100
Subject: [PATCH 08/16] Generalize handle_ramdisks() and rename to
 handle_cmdline_files().
In-Reply-To: <1376090777-20090-9-git-send-email-roy.franz@linaro.org>
References: <1376090777-20090-1-git-send-email-roy.franz@linaro.org>
 <1376090777-20090-9-git-send-email-roy.franz@linaro.org>
Message-ID: <20130830133138.AEFF83E102A@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  9 Aug 2013 16:26:09 -0700, Roy Franz <roy.franz@linaro.org> wrote:
> The handle_cmdline_files now takes the option to handle as a string,
> and returns the loaded data through parameters, rather than taking
> an x86 specific setup_header structure.  For ARM, this will be used
> to load a device tree blob in addition to initrd images.
> 
> Signed-off-by: Roy Franz <roy.franz@linaro.org>

Minor comment below, but otherwise looks good:

Reviewed-by: Grant Likely <grant.likely@linaro.org>

> ---
> @@ -380,7 +388,7 @@ static efi_status_t handle_ramdisks(efi_system_table_t *sys_table_arg,
>  		status = efi_call_phys5(fh->open, fh, &h, filename_16,
>  					EFI_FILE_MODE_READ, (u64)0);
>  		if (status != EFI_SUCCESS) {
> -			efi_printk(sys_table_arg, "Failed to open initrd file: ");
> +			efi_printk(sys_table_arg, "Failed to open file file: ");

"file file:"? Search and replace artifact?
