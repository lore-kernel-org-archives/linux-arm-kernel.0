From: matt@console-pimps.org (Matt Fleming)
Date: Thu, 27 Nov 2014 17:30:15 +0000
Subject: [PATCH v3 12/13] efi: efistub: allow allocation alignment larger
 than EFI_PAGE_SIZE
In-Reply-To: <1416315432-8534-13-git-send-email-ard.biesheuvel@linaro.org>
References: <1416315432-8534-1-git-send-email-ard.biesheuvel@linaro.org>
 <1416315432-8534-13-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20141127173015.GH3331@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Nov, at 01:57:11PM, Ard Biesheuvel wrote:
> On systems with 64 KB pages, it is preferable for UEFI memory map
> entries to be 64 KB aligned multiples of 64 KB, because it relieves
> us of having to deal with the residues.
> So, if EFI_ALLOC_ALIGN is #define'd by the platform, use it to round
> up all memory allocations made.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)

Looks OK to me.

Acked-by: Matt Fleming <matt.fleming@intel.com>

-- 
Matt Fleming, Intel Open Source Technology Center
