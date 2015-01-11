From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 11 Jan 2015 19:08:05 +0100
Subject: [PATCH 3/7] arm64: remove ESR_EL1_* macros
In-Reply-To: <1420632260-8798-4-git-send-email-mark.rutland@arm.com>
References: <1420632260-8798-1-git-send-email-mark.rutland@arm.com>
 <1420632260-8798-4-git-send-email-mark.rutland@arm.com>
Message-ID: <20150111180805.GJ21444@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 07, 2015 at 12:04:16PM +0000, Mark Rutland wrote:
> Now that all users have been moved over to the common ESR_ELx_* macros,
> remove the redundant ESR_EL1 macros.
> 
> There should be no functional change as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>

FYI: This breaks bisectability with KVM, so we should probably move the
existing KVM references to the common definitions as part of this patch?

-Christoffer
