From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 20 Mar 2017 18:25:26 -0500
Subject: [PATCH v2 2/2] efi: arm-stub: Round up FDT allocation to mapping
 size
In-Reply-To: <1486676573-19237-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1486676573-19237-1-git-send-email-ard.biesheuvel@linaro.org>
 <1486676573-19237-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CAOZdJXVrpKQOigp9uDMJ=wW=j_y4XzNf+Ham9huFUTbc6UxDSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 9, 2017 at 3:42 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> The FDT is mapped via a fixmap entry that is at least 2 MB in size and
> 2 MB aligned on 4 KB page size kernels.
>
> On UEFI systems, the FDT allocation may share this 2 MB block with a
> reserved region, or another memory region that we should never map,
> unless we account for this in the size of the allocation (the alignment
> is already 2 MB)
>
> So instead of taking guesses at the needed space, simply allocate 2 MB
> immediately. The allocation will be recorded as a EFI_LOADER_DATA, and
> the kernel only memblock_reserve()'s the actual size of the FDT, so the
> unused space will be released to the kernel.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

This patch is over a month old, and it's been reviewed and tested.  We
really need this in 4.11.  Please get this merged into 4.11-rc4.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
