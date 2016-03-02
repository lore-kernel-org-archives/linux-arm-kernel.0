From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Wed, 2 Mar 2016 11:49:01 +0000
Subject: [PATCH 1/5] ARM: efi: apply strict permissons for UEFI Runtime
 Services regions
In-Reply-To: <1456151158-25849-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1456151158-25849-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456151158-25849-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160302114901.GC2649@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Feb, at 03:25:54PM, Ard Biesheuvel wrote:
> Recent UEFI versions expose permission attributes for runtime services
> memory regions, either in the UEFI memory map or in the separate memory
> attributes table.  This allows the kernel to map these regions with
> stricter permissions, rather than the RWX permissions that are used by
> default. So wire this up in our mapping routine.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm/include/asm/efi.h |  1 +
>  arch/arm/kernel/efi.c      | 41 ++++++++++++++++++++
>  2 files changed, 42 insertions(+)

Looks fine from an EFI perspective, but it would be nice for somebody
else with ARM knowledge to ACK it.
