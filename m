From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Jul 2015 15:43:58 +0100
Subject: [PATCH v2 08/20] arm64: atomics: patch in lse instructions when
 supported by the CPU
In-Reply-To: <1437734531-10698-9-git-send-email-will.deacon@arm.com>
References: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
 <1437734531-10698-9-git-send-email-will.deacon@arm.com>
Message-ID: <20150724144358.GI3550@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 11:41:59AM +0100, Will Deacon wrote:
> On CPUs which support the LSE atomic instructions introduced in ARMv8.1,
> it makes sense to use them in preference to ll/sc sequences.
> 
> This patch introduces runtime patching of atomic_t and atomic64_t
> routines so that the call-site for the out-of-line ll/sc sequences is
> patched with an LSE atomic instruction when we detect that
> the CPU supports it.
> 
> If binutils is not recent enough to assemble the LSE instructions, then
> the ll/sc sequences are inlined as though CONFIG_ARM64_LSE_ATOMICS=n.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
