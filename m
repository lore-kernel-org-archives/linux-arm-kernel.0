From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 19 Apr 2016 15:44:25 +0100
Subject: [PATCH v7 03/16] arm64: Cleanup SCTLR flags
In-Reply-To: <1459529620-22150-4-git-send-email-james.morse@arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1459529620-22150-4-git-send-email-james.morse@arm.com>
Message-ID: <57164449.4060708@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04/16 17:53, James Morse wrote:
> From: Geoff Levand <geoff@infradead.org>
> 
> We currently have macros defining flags for the arm64 sctlr registers in
> both kvm_arm.h and sysreg.h.  To clean things up and simplify move the
> definitions of the SCTLR_EL2 flags from kvm_arm.h to sysreg.h, rename any
> SCTLR_EL1 or SCTLR_EL2 flags that are common to both registers to be
> SCTLR_ELx, with 'x' indicating a common flag, and fixup all files to
> include the proper header or to use the new macro names.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> [Restored pgtable-hwdef.h include]
> Signed-off-by: James Morse <james.morse@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
