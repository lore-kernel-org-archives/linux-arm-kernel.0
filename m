From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Thu, 21 Jan 2016 16:20:56 +0000
Subject: [PATCH v3 20/21] efi: stub: use high allocation for converted
 command line
In-Reply-To: <1452518355-4606-22-git-send-email-ard.biesheuvel@linaro.org>
References: <1452518355-4606-1-git-send-email-ard.biesheuvel@linaro.org>
 <1452518355-4606-22-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160121162056.GG2510@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Jan, at 02:19:14PM, Ard Biesheuvel wrote:
> Before we can move the command line processing before the allocation
> of the kernel, which is required for detecting the 'nokaslr' option
> which controls that allocation, move the converted command line higher
> up in memory, to prevent it from interfering with the kernel itself.
> 
> Since x86 needs the address to fit in 32 bits, use UINT_MAX as the upper
> bound there. Otherwise, use ULONG_MAX (i.e., no limit)
> 
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/x86/include/asm/efi.h                     |  2 ++
>  drivers/firmware/efi/libstub/efi-stub-helper.c | 14 +++++++++++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
