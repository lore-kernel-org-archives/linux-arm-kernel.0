From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 29 Oct 2015 09:52:13 -0500
Subject: [PATCH] arm64/efi: do not assume DRAM base is aligned to 2 MB
In-Reply-To: <1446127645-4115-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1446127645-4115-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <5632329D.3010306@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/29/2015 09:07 AM, Ard Biesheuvel wrote:
> The current arm64 Image relocation code in the UEFI stub assumes that
> the dram_base argument it receives is always a multiple of 2 MB. In
> reality, it is simply the lowest start address of all RAM entries in
> the UEFI memory map, which means it could be any multiple of 4 KB.
>
> Since the arm64 kernel Image needs to reside TEXT_OFFSET bytes beyond
> a 2 MB aligned base, or it will fail to boot, make sure we round dram_base
> to 2 MB before using it to calculate the relocation address.
>
> Reported-by: Timur Tabi<timur@codeaurora.org>
> Acked-by: Mark Rutland<mark.rutland@arm.com>
> Signed-off-by: Ard Biesheuvel<ard.biesheuvel@linaro.org>

This works for me

Tested-by: Timur Tabi<timur@codeaurora.org>

On my system, dram_base is 0x4000820000, and *image_addr is 
0x43956db000, preferred_offset is set to 0x4000880000.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
