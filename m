From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 22 Nov 2014 21:02:54 +0100
Subject: [PATCH v2 3/3] KVM: arm/arm64: Enable Dirty Page logging for ARMv8
In-Reply-To: <1416039550-28125-4-git-send-email-m.smarduch@samsung.com>
References: <1416039550-28125-1-git-send-email-m.smarduch@samsung.com>
 <1416039550-28125-4-git-send-email-m.smarduch@samsung.com>
Message-ID: <20141122200254.GS3401@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 15, 2014 at 12:19:10AM -0800, m.smarduch at samsung.com wrote:
> From: Mario Smarduch <m.smarduch@samsung.com>
> 
> This patch enables ARMv8 ditry page logging support. Plugs ARMv8 into generic
> layer through Kconfig symbol, and drops earlier ARM64 constraints to enable
> logging at architecture layer.
> 
> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>

Just reminding you again of what I said in the previous thread (think
that was before you sent this out), that you need to handle the pud_huge
case in arch/arm/kvm/mmu.c for ARMv8 here.

-Christoffer
