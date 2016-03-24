From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 24 Mar 2016 16:19:37 +0000
Subject: [PATCH] arm64: kaslr: use callee saved register to preserve
 SCTLR across C call
In-Reply-To: <1458581711-13950-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1458581711-13950-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160324161937.GD9113@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2016 at 06:35:11PM +0100, Ard Biesheuvel wrote:
> The KASLR code incorrectly expects the contents of x18 to be preserved
> across a call into C code, and uses it to stash the contents of SCTLR_EL1
> before enabling the MMU. If the MMU needs to be disabled again to create
> the randomized kernel mapping, x18 is written back to SCTLR_EL1, which is
> likely to crash the system if x18 has been clobbered by kasan_early_init()
> or kaslr_early_init(). So use x22 instead, which is not in use so far in
> head.S
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Applied. Thanks.

-- 
Catalin
