From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 26 Feb 2018 14:27:44 +0000
Subject: [PATCH] arm64: mm: fix thinko in non-global page table attribute
 check
In-Reply-To: <20180223180448.6006-1-ard.biesheuvel@linaro.org>
References: <20180223180448.6006-1-ard.biesheuvel@linaro.org>
Message-ID: <20180226142743.evt7hkr7wsh452qc@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 23, 2018 at 06:04:48PM +0000, Ard Biesheuvel wrote:
> The routine pgattr_change_is_safe() was extended in commit 4e6020565596
> ("arm64: mm: Permit transitioning from Global to Non-Global without BBM")
> to permit changing the nG attribute from not set to set, but did so in a
> way that inadvertently disallows such changes if other permitted attribute
> changes take place at the same time. So update the code to take this into
> account.
> 
> Fixes: 4e6020565596 ("arm64: mm: Permit transitioning from Global to ...")
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Queued for 4.16. Thanks.

-- 
Catalin
