From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 May 2015 18:29:32 +0100
Subject: [PATCHv2 05/12] arm64: psci: support unsigned return values
In-Reply-To: <1431945503-6939-6-git-send-email-mark.rutland@arm.com>
References: <1431945503-6939-1-git-send-email-mark.rutland@arm.com>
 <1431945503-6939-6-git-send-email-mark.rutland@arm.com>
Message-ID: <20150518172932.GL21251@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 11:38:16AM +0100, Mark Rutland wrote:
> PSCI_VERSION and MIGRATE_INFO_TYPE_UP_CPU return unsigned values, with
> the latter returning a 64-bit value. However, the PSCI invocation
> functions have prototypes returning int.
> 
> This patch upgrades the invocation functions to return unsigned long,
> with a new typedef to keep things legible. As PSCI_VERSION cannot return
> a negative value, the erroneous check against PSCI_RET_NOT_SUPPORTED is
> also removed. The unrelated psci_initcall_t typedef is moved closer to
> its first user, to avoid confusion with the invocation functions.
> 
> In preparation for sharing the code with ARM, unsigned long is used in
> preference of u64. In the SMC32 calling convention, the relevant fields
> will be 32 bits wide.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
