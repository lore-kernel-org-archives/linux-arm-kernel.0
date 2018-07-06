From: will.deacon@arm.com (Will Deacon)
Date: Fri, 6 Jul 2018 17:42:10 +0100
Subject: [PATCHv4 00/19] arm64: invoke syscalls with pt_regs
In-Reply-To: <20180702110415.10465-1-mark.rutland@arm.com>
References: <20180702110415.10465-1-mark.rutland@arm.com>
Message-ID: <20180706164210.GC27483@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2018 at 12:03:56PM +0100, Mark Rutland wrote:
> This series reworks arm64's syscall handling to minimize the propagation
> of user-controlled register values into speculated code paths. As with
> x86 [1], a wrapper is generated for each syscall, which extracts the
> argument from a struct pt_regs. During kernel entry from userspace,
> registers are zeroed.
> 
> The arm64 kernel code directly invokes some syscalls which the x86 code
> doesn't, so I've added ksys_* wrappers for these, following the x86
> example. The rest of the series is arm64-specific.
> 
> I've pushed the series out to my arm64/syscall-regs branch [2] on
> kernel.org.

Modulo the macro label nit in the ssbd code, this series looks fine to
me.

Catalin -- have you thrown this at LTP?

Will
