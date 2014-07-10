From: matt@console-pimps.org (Matt Fleming)
Date: Thu, 10 Jul 2014 11:04:26 +0100
Subject: [PATCH] efi: fdt: Do not report an error during boot if UEFI is
 not available
In-Reply-To: <1404834858-10706-1-git-send-email-catalin.marinas@arm.com>
References: <1404834858-10706-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <20140710100426.GD15932@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 08 Jul, at 04:54:18PM, Catalin Marinas wrote:
> Currently, fdt_find_uefi_params() reports an error if no EFI parameters
> are found in the DT. This is however a valid case for non-UEFI kernel
> booting. This patch checks changes the error reporting to a
> pr_info("UEFI not found") when no EFI parameters are found in the DT.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Leif Lindholm <leif.lindholm@linaro.org>
> Tested-by: Leif Lindholm <leif.lindholm@linaro.org>
> ---
>  drivers/firmware/efi/efi.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)

Thanks, applied to 'urgent' for v3.16.

-- 
Matt Fleming, Intel Open Source Technology Center
