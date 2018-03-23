From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 23 Mar 2018 08:52:01 +0000
Subject: [PATCH v2] arm/arm64: smccc: Fix CLANG compilation for arm64
In-Reply-To: <1521751838-18912-1-git-send-email-isaacm@codeaurora.org>
References: <1521751838-18912-1-git-send-email-isaacm@codeaurora.org>
Message-ID: <29721ee6-25bf-5067-f774-aa1c919873d6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/03/18 20:50, Isaac J. Manjarres wrote:
> When CLANG compiles inline assembly for 64 bit ARM
> architectures, it is unable to map register names,
> such as "r0" to the correct alias, such as "x0" for 64
> bit accesses, and "w0" for 32 bit accesses. While GCC
> can perform this mapping, CLANG can not, which results in
> compilation failures when building the kernel. Allow for
> differentiation of which register names to use, based on
> ARM architecture, to compile the kernel with CLANG.
> 
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Please see the other 2 threads on the list. There is a fix under way for
Clang, so I don't think there is a need for this hack.

If you're using Clang to compile the kernel, you're already carrying a
number of extra patches, so adding this one shouldn't be a big deal.
Once Clang gains feature parity with GCC, you'll be able to drop it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
