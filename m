From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Oct 2015 14:20:16 +0100
Subject: [PATCH v2] arm64: hw_breakpoint: use target state to determine
 ABI behaviour
In-Reply-To: <1444214256-24158-1-git-send-email-will.deacon@arm.com>
References: <1444214256-24158-1-git-send-email-will.deacon@arm.com>
Message-ID: <20151007132016.GA17192@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 11:37:36AM +0100, Will Deacon wrote:
> The arm64 hw_breakpoint interface is slightly less flexible than its
> 32-bit counterpart, thanks to some changes in the architecture rendering
> unaligned watchpoint addresses obselete for AArch64.
> 
> However, in a multi-arch environment (i.e. debugging a 32-bit target
> with a 64-bit GDB under a 64-bit kernel), we need to provide a feature
> compatible interface to GDB in order for debugging to function correctly.
> 
> This patch adds a new helper, is_compat_bp,  to our hw_breakpoint
> implementation which changes the interface behaviour based on the
> architecture of the debug target as opposed to the debugger itself.
> This allows debugged to function as expected for multi-arch
> configurations without relying on deprecated architectural behaviours
> when debugging native applications.
> 
> Cc: Yao Qi <yao.qi@arm.com>
> Cc: Catalin Marinas <Catalin.Marinas@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Queued for 4.4. Thanks.

-- 
Catalin
