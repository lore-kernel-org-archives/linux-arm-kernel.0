From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 10 Feb 2016 10:41:16 +0000
Subject: [PATCH] arm64: prefetch: add missing #include for
 spin_lock_prefetch
In-Reply-To: <1455098850-3551-1-git-send-email-will.deacon@arm.com>
References: <1455098850-3551-1-git-send-email-will.deacon@arm.com>
Message-ID: <20160210104116.GD13577@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 10:07:30AM +0000, Will Deacon wrote:
> As of 52e662326e1e ("arm64: prefetch: don't provide spin_lock_prefetch
> with LSE"), spin_lock_prefetch is patched at runtime when the LSE atomics
> are in use. This relies on the ARM64_LSE_ATOMIC_INSN macro to drive
> the alternatives framework, but that macro is only available via
> asm/lse.h, which isn't explicitly included in processor.h. Consequently,
> drivers can run into build failures such as:
> 
>    In file included from include/linux/prefetch.h:14:0,
>                     from drivers/net/ethernet/intel/i40e/i40e_txrx.c:27:
>    arch/arm64/include/asm/processor.h: In function 'spin_lock_prefetch':
>    arch/arm64/include/asm/processor.h:183:15: error: expected string literal before 'ARM64_LSE_ATOMIC_INSN'
>      asm volatile(ARM64_LSE_ATOMIC_INSN(
> 
> This patch add the missing include and gets things building again.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Applied. Thanks.

-- 
Catalin
