From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Apr 2018 19:06:38 +0100
Subject: [RFC PATCH 4/8] arm64/sve: Move read_zcr_features() out of
 cpufeature.h
In-Reply-To: <1524242802-21163-5-git-send-email-Dave.Martin@arm.com>
References: <1524242802-21163-1-git-send-email-Dave.Martin@arm.com>
 <1524242802-21163-5-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180425180637.qw5llrrjdnh7gnei@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2018 at 05:46:38PM +0100, Dave P Martin wrote:
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

I guess when you eventually drop the RFC, these patches would be merged
through the KVM tree. For the core arm64 parts:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

The KVM changes also look fine to me but I'm not a KVM expert.

-- 
Catalin
