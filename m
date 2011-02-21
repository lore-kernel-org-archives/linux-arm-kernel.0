From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Feb 2011 09:46:22 +0000
Subject: [PATCH 1/2] ARM: l2x0: Errata fix for flush by Way operation can
	cause data corruption
In-Reply-To: <1298032525-21115-2-git-send-email-santosh.shilimkar@ti.com>
References: <1298032525-21115-1-git-send-email-santosh.shilimkar@ti.com>
	<1298032525-21115-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <AANLkTi=75FCNufKQsJTqREbsNhmwP-QrU7uUUtBr_i8-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 February 2011 12:35, Santosh Shilimkar <santosh.shilimkar@ti.com> wrote:
> PL310 implements the Clean & Invalidate by Way L2 cache maintenance
> operation (offset 0x7FC). This operation runs in background so that
> PL310 can handle normal accesses while it is in progress. Under very
> rare circumstances, due to this erratum, write data can be lost when
> PL310 treats a cacheable write transaction during a Clean & Invalidate
> by Way operation.
>
> Workaround:
> Disable Write-Back and Cache Linefill (Debug Control Register)
> Clean & Invalidate by Way (0x7FC)
> Re-enable Write-Back and Cache Linefill (Debug Control Register)
>
> This patch also removes any OMAP dependency on PL310 Errata's
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
