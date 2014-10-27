From: matt@console-pimps.org (Matt Fleming)
Date: Mon, 27 Oct 2014 15:26:11 +0000
Subject: [PATCH 07/10] efi: dmi: add support for SMBIOS 3.0 UEFI
 configuration table
In-Reply-To: <1413987713-30528-8-git-send-email-ard.biesheuvel@linaro.org>
References: <1413987713-30528-1-git-send-email-ard.biesheuvel@linaro.org>
 <1413987713-30528-8-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20141027152611.GN12020@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Oct, at 04:21:50PM, Ard Biesheuvel wrote:
> This adds support to the UEFI side for detecting the presence of
> a SMBIOS 3.0 64-bit entry point. This allows the actual SMBIOS
> structure table to reside at a physical offset over 4 GB, which
> cannot be supported by the legacy SMBIOS 32-bit entry point.
> 
> Since the firmware can legally provide both entry points, store
> the SMBIOS 3.0 entry point in a separate variable, and let the
> DMI decoding layer decide which one will be used.
> 
> Tested-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Acked-by: Leif Lindholm <leif.lindholm@linaro.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/firmware/efi/efi.c | 4 ++++
>  include/linux/efi.h        | 6 +++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)

Looks like you might also need to change driver/xen/efi.c to set
EFI_INVALID_TABLE_ADDR for the new table address?

-- 
Matt Fleming, Intel Open Source Technology Center
