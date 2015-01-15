From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Thu, 15 Jan 2015 21:27:34 +0000
Subject: [PATCH v2] arm64/efi: efistub: apply __init annotation
In-Reply-To: <1421094500-15659-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1421094500-15659-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150115212734.GD12079@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Jan, at 08:28:20PM, Ard Biesheuvel wrote:
> This ensures all stub component are freed when the kernel proper is
> done booting, by prefixing the names of all ELF sections that have
> the SHF_ALLOC attribute with ".init". This approach ensures that even
> implicitly emitted allocated data (like initializer values and string
> literals) are covered.
> 
> At the same time, remove some __init annotations in the stub that have
> now become redundant, and add the __init annotation to handle_kernel_image
> which will now trigger a section mismatch warning without it.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v2: fixed an issue with spurious rebuilding of object files, now setting
>     $(extra-y) correctly, which also allows the .PRECIOUS: to be dropped.
> 
> 
>  arch/arm64/kernel/efi-stub.c                   | 14 +++++++-------
>  drivers/firmware/efi/libstub/Makefile          | 14 ++++++++++++++
>  drivers/firmware/efi/libstub/arm-stub.c        |  8 ++++----
>  drivers/firmware/efi/libstub/efi-stub-helper.c |  2 +-
>  4 files changed, 26 insertions(+), 12 deletions(-)

Applied for v3.20, thanks Ard.

-- 
Matt Fleming, Intel Open Source Technology Center
