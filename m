From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 20 Jul 2016 18:04:33 +0100
Subject: [PATCH v15 04/10] arm64: Kprobes with single stepping support
In-Reply-To: <578FAB02.90707@arm.com>
References: <1467995754-32508-1-git-send-email-dave.long@linaro.org>
 <1467995754-32508-5-git-send-email-dave.long@linaro.org>
 <578FA238.3050206@arm.com>
 <20160720162827.GF25890@e104818-lin.cambridge.arm.com>
 <578FAB02.90707@arm.com>
Message-ID: <20160720170432.GH25890@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 05:46:58PM +0100, Marc Zyngier wrote:
> From 0d120f95b3348e1946d8a789c7147f316c27ea6b Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <marc.zyngier@arm.com>
> Date: Wed, 20 Jul 2016 17:36:42 +0100
> Subject: [PATCH] arm64: kprobes: Fix overflow when saving stack
> 
> The MIN_STACK_SIZE macro tries evaluate how much stack space needs
> to be saved in the jprobes_stack array, sized at 128 bytes.
> 
> When using the IRQ stack, said macro can happily return up to
> IRQ_STACK_SIZE, which is 16kB. Mayhem follows.
> 
> This patch fixes things by getting rid of the crazy macro and
> limiting the copy to be at most the size of the jprobes_stack
> array, no matter which stack we're on.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Applied to the kprobes branch. Thanks.

(I can't yet tell whether kprobes will make into 4.8; I need to run some
more tests before deciding)

-- 
Catalin
