From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 9 Mar 2018 17:52:25 +0000
Subject: [PATCH] arm64: Relax ARM_SMCCC_ARCH_WORKAROUND_1 discovery
In-Reply-To: <20180309154050.30656-1-marc.zyngier@arm.com>
References: <20180309154050.30656-1-marc.zyngier@arm.com>
Message-ID: <20180309175224.j6rmcxvrij24uwyx@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2018 at 03:40:50PM +0000, Marc Zyngier wrote:
> A recent update to the ARM SMCCC ARCH_WORKAROUND_1 specification
> allows firmware to return a non zero, positive value to describe
> that although the mitigation is implemented at the higher exception
> level, the CPU on which the call is made is not affected.
> 
> Let's relax the check on the return value from ARCH_WORKAROUND_1
> so that we only error out if the returned value is negative.
> 
> Fixes: b092201e0020 ("arm64: Add ARM_SMCCC_ARCH_WORKAROUND_1 BP hardening support")
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Queued for 4.16. Thanks.

-- 
Catalin
