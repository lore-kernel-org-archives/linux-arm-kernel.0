From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 24 Apr 2018 18:03:41 +0100
Subject: [PATCH] arm64: ptrace: remove addr_limit manipulation
In-Reply-To: <20180424121122.30294-1-mark.rutland@arm.com>
References: <20180424121122.30294-1-mark.rutland@arm.com>
Message-ID: <20180424170340.kav3ts4pjd7quvyw@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 01:11:22PM +0100, Mark Rutland wrote:
> We transiently switch to KERNEL_DS in compat_ptrace_gethbpregs() and
> compat_ptrace_sethbpregs(), but in either case this is pointless as we
> don't perform any uaccess during this window.
> 
> let's rip out the redundant addr_limit manipulation.

It looks like some leftovers from an internal tree prior to upstreaming.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
