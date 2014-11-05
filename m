From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 5 Nov 2014 11:27:50 +0000
Subject: [PATCHv3 1/5] arm64: Add support for hooks to handle undefined
 instructions
In-Reply-To: <1414435207-30240-2-git-send-email-punit.agrawal@arm.com>
References: <1414435207-30240-1-git-send-email-punit.agrawal@arm.com>
 <1414435207-30240-2-git-send-email-punit.agrawal@arm.com>
Message-ID: <20141105112750.GD32700@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 27, 2014 at 06:40:02PM +0000, Punit Agrawal wrote:
> --- a/arch/arm64/include/asm/insn.h
> +++ b/arch/arm64/include/asm/insn.h
> @@ -354,6 +354,8 @@ bool aarch64_insn_hotpatch_safe(u32 old_insn, u32 new_insn);
>  int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
>  int aarch64_insn_patch_text_sync(void *addrs[], u32 insns[], int cnt);
>  int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
> +
> +bool aarch32_insn_is_wide_instruction(u32 insn);

Nitpick: too wide function name ;). Maybe aarch32_insn_is_wide().

Otherwise the patch looks fine.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
