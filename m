From: matt@console-pimps.org (Matt Fleming)
Date: Tue, 4 Nov 2014 17:20:41 +0000
Subject: [PATCH v2 06/10] efi: dmi: add support for SMBIOS 3.0 UEFI
 configuration table
In-Reply-To: <1414513123-20400-7-git-send-email-ard.biesheuvel@linaro.org>
References: <1414513123-20400-1-git-send-email-ard.biesheuvel@linaro.org>
 <1414513123-20400-7-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20141104172041.GB3592@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Oct, at 05:18:39PM, Ard Biesheuvel wrote:
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
>  drivers/xen/efi.c          | 1 +
>  include/linux/efi.h        | 6 +++++-
>  3 files changed, 10 insertions(+), 1 deletion(-)

Acked-by: Matt Fleming <matt.fleming@intel.com>

-- 
Matt Fleming, Intel Open Source Technology Center
