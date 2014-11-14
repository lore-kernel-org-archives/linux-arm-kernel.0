From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 14 Nov 2014 18:32:41 +0000
Subject: [PATCHv4 4/5] arm64: Emulate CP15 Barrier instructions
In-Reply-To: <1415792692-11189-5-git-send-email-punit.agrawal@arm.com>
References: <1415792692-11189-1-git-send-email-punit.agrawal@arm.com>
 <1415792692-11189-5-git-send-email-punit.agrawal@arm.com>
Message-ID: <20141114183240.GF6755@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12, 2014 at 11:44:51AM +0000, Punit Agrawal wrote:
> The CP15 barrier instructions (CP15ISB, CP15DSB and CP15DMB) are
> deprecated in the ARMv7 architecture, superseded by ISB, DSB and DMB
> instructions respectively. Some implementations may provide the
> ability to disable the CP15 barriers by disabling the CP15BEN bit in
> SCTLR_EL1. If not enabled, the encodings for these instructions become
> undefined.
> 
> To support legacy software using these instructions, this patch
> register hooks to -
> * emulate CP15 barriers and warn the user about their use
> * toggle CP15BEN in SCTLR_EL1
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
