From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 9 May 2018 09:28:50 +0100
Subject: [PATCH v6 08/15] arm64/sve: Move read_zcr_features() out of
 cpufeature.h
In-Reply-To: <1525797900-5548-9-git-send-email-Dave.Martin@arm.com>
References: <1525797900-5548-1-git-send-email-Dave.Martin@arm.com>
 <1525797900-5548-9-git-send-email-Dave.Martin@arm.com>
Message-ID: <2d335ebd-a17e-cf0f-5d59-398f721ce43e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/18 17:44, Dave Martin wrote:
> Having read_zcr_features() inline in cpufeature.h results in that
> header requiring #includes which make it hard to include
> <asm/fpsimd.h> elsewhere without triggering header inclusion
> cycles.
> 
> This is not a hot-path function and arguably should not be in
> cpufeature.h in the first place, so this patch moves it to
> fpsimd.c, compiled conditionally if CONFIG_ARM64_SVE=y.
> 
> This allows some SVE-related #includes to be dropped from
> cpufeature.h, which will ease future maintenance.
> 
> A couple of missing #includes of <asm/fpsimd.h> are exposed by this
> change under arch/arm64/.  This patch adds the missing #includes as
> necessary.
> 
> No functional change.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
