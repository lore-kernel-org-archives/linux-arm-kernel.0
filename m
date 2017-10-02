From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 2 Oct 2017 10:53:31 +0100
Subject: [PATCH v5 4/7] arm64: sysreg: Move SPE registers and PSB into
 common header files
In-Reply-To: <1506607791-8621-5-git-send-email-will.deacon@arm.com>
References: <1506607791-8621-1-git-send-email-will.deacon@arm.com>
 <1506607791-8621-5-git-send-email-will.deacon@arm.com>
Message-ID: <52fd705d-2c6a-98f6-ba58-858ab770ac72@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/09/17 15:09, Will Deacon wrote:
> SPE is part of the v8.2 architecture, so move its system register and
> field definitions into sysreg.h and the new PSB barrier into barrier.h
> 
> Finally, move KVM over to using the generic definitions so that it
> doesn't have to open-code its own versions.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/barrier.h |  2 +
>  arch/arm64/include/asm/sysreg.h  | 93 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm64/kvm/hyp/debug-sr.c    | 24 +++--------
>  3 files changed, 102 insertions(+), 17 deletions(-)

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
