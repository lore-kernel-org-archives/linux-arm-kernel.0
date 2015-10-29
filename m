From: will.deacon@arm.com (Will Deacon)
Date: Thu, 29 Oct 2015 14:57:55 +0000
Subject: [PATCH] arm64/efi: do not assume DRAM base is aligned to 2 MB
In-Reply-To: <1446127645-4115-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1446127645-4115-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151029145754.GD3440@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 29, 2015 at 03:07:25PM +0100, Ard Biesheuvel wrote:
> The current arm64 Image relocation code in the UEFI stub assumes that
> the dram_base argument it receives is always a multiple of 2 MB. In
> reality, it is simply the lowest start address of all RAM entries in
> the UEFI memory map, which means it could be any multiple of 4 KB.
> 
> Since the arm64 kernel Image needs to reside TEXT_OFFSET bytes beyond
> a 2 MB aligned base, or it will fail to boot, make sure we round dram_base
> to 2 MB before using it to calculate the relocation address.
> 
> Reported-by: Timur Tabi <timur@codeaurora.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> If deemed acceptable, could we either get this into v4.3 or tag it for
> stable (v4.3 only) please?

So is this fixing a regression introduced in 4.3? If so, can I have a
Fixes: tag too, please? (I was under the impression that this was a
longstanding issue, but the thread hasn't been easy to follow).

Will
