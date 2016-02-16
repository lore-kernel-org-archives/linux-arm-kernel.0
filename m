From: will.deacon@arm.com (Will Deacon)
Date: Tue, 16 Feb 2016 10:32:54 +0000
Subject: [PATCH v2] arm64/efi: Make strnlen() available to the EFI
 namespace
In-Reply-To: <1455617791-4791-1-git-send-email-thierry.reding@gmail.com>
References: <1455563856-1553-1-git-send-email-thierry.reding@gmail.com>
 <1455617791-4791-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <20160216103254.GD14509@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 11:16:31AM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Changes introduced in the upstream version of libfdt pulled in by commit
> 91feabc2e224 ("scripts/dtc: Update to upstream commit b06e55c88b9b") use
> the strnlen() function, which isn't currently available to the EFI name-
> space. Add it to the EFI namespace to avoid a linker error.
> 
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - mark strnlen() position independent and refer to __pi_strnlen

Thanks, I'll queue this on the arm64 fixes branch.

Will
