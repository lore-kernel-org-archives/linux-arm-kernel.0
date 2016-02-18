From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Thu, 18 Feb 2016 10:15:01 +0000
Subject: [PATCH v5sub3 4/4] arm64: efi: invoke EFI_RNG_PROTOCOL to supply
 KASLR randomness
In-Reply-To: <1455126905-22688-5-git-send-email-ard.biesheuvel@linaro.org>
References: <1455126905-22688-1-git-send-email-ard.biesheuvel@linaro.org>
 <1455126905-22688-5-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160218101501.GA2651@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Feb, at 06:55:05PM, Ard Biesheuvel wrote:
> Since arm64 does not use a decompressor that supplies an execution
> environment where it is feasible to some extent to provide a source of
> randomness, the arm64 KASLR kernel depends on the bootloader to supply
> some random bits in the /chosen/kaslr-seed DT property upon kernel entry.
> 
> On UEFI systems, we can use the EFI_RNG_PROTOCOL, if supplied, to obtain
> some random bits. At the same time, use it to randomize the offset of the
> kernel Image in physical memory.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/Kconfig                        |  5 ++
>  drivers/firmware/efi/libstub/arm-stub.c   | 40 ++++++----
>  drivers/firmware/efi/libstub/arm64-stub.c | 78 ++++++++++++++------
>  drivers/firmware/efi/libstub/fdt.c        | 14 ++++
>  4 files changed, 102 insertions(+), 35 deletions(-)

Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
