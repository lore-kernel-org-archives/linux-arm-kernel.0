From: matt@console-pimps.org (Matt Fleming)
Date: Mon, 5 Jan 2015 14:55:10 +0000
Subject: [PATCH v4 3/8] efi: split off remapping code from
 efi_config_init()
In-Reply-To: <1419245944-2424-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1419245944-2424-1-git-send-email-ard.biesheuvel@linaro.org>
 <1419245944-2424-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150105145510.GD3163@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Dec, at 10:58:59AM, Ard Biesheuvel wrote:
> Split of the remapping code from efi_config_init() so that the caller
> can perform its own remapping. This is necessary to correctly handle
> virtually remapped UEFI memory regions under kexec, as efi.systab will
> have been updated to a virtual address.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/firmware/efi/efi.c | 49 +++++++++++++++++++++++++++++-----------------
>  include/linux/efi.h        |  2 ++
>  2 files changed, 33 insertions(+), 18 deletions(-)

Looks good Ard.

Acked-by: Matt Fleming <matt.fleming@intel.com>

-- 
Matt Fleming, Intel Open Source Technology Center
