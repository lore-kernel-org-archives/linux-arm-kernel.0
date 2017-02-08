From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 8 Feb 2017 10:28:11 -0600
Subject: [PATCH v3 06/10] arm64: efi: add EFI stub
In-Reply-To: <1396637113-22790-7-git-send-email-leif.lindholm@linaro.org>
References: <1396637113-22790-1-git-send-email-leif.lindholm@linaro.org>
 <1396637113-22790-7-git-send-email-leif.lindholm@linaro.org>
Message-ID: <CAOZdJXWU1dmFfCc88RMp3SvouU7roDiJsA=3aHzwijwhMH7naA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 4, 2014 at 1:45 PM, Leif Lindholm <leif.lindholm@linaro.org> wrote:
>
> +/*
> + * EFI entry point for the arm/arm64 EFI stubs.  This is the entrypoint
> + * that is described in the PE/COFF header.  Most of the code is the same
> + * for both archictectures, with the arch-specific code provided in the
> + * handle_kernel_image() function.
> + */
> +unsigned long __init efi_entry(void *handle, efi_system_table_t *sys_table,
> +                              unsigned long *image_addr)
> +{

...

> +
> +       status = handle_cmdline_files(sys_table, image, cmdline_ptr,
> +                                     "initrd=", dram_base + SZ_512M,
> +                                     (unsigned long *)&initrd_addr,
> +                                     (unsigned long *)&initrd_size);

So I know this patch is almost three years old, but why is there a
512M limit on the initrd size?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
