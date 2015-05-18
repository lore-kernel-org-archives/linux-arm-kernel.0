From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 May 2015 18:28:09 +0100
Subject: [PATCHv2 04/12] arm64: psci: remove unnecessary id indirection
In-Reply-To: <1431945503-6939-5-git-send-email-mark.rutland@arm.com>
References: <1431945503-6939-1-git-send-email-mark.rutland@arm.com>
 <1431945503-6939-5-git-send-email-mark.rutland@arm.com>
Message-ID: <20150518172809.GK21251@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 11:38:15AM +0100, Mark Rutland wrote:
> PSCI 0.1 did not define canonical IDs for CPU_ON, CPU_OFF, CPU_SUSPEND,
> or MIGRATE, and so these need to be provided when using firmware
> compliant to PSCI 0.1.
> 
> However, functions introduced in 0.2 or later have canonical IDs, and
> these cannot be provided via DT. There's no need to indirect the IDs via
> a table; they can be used directly at callsites (and already are for
> SYSTEM_OFF and SYSTEM_RESET).
> 
> This patch removes the unnecessary function ID indirection for
> AFFINITY_INFO and MIGRATE_INFO_TYPE.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
