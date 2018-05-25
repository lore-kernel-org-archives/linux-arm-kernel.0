From: will.deacon@arm.com (Will Deacon)
Date: Fri, 25 May 2018 16:20:23 +0100
Subject: [PATCH v5 2/2] arm64: signal: Report signal frame size to
 userspace via auxv
In-Reply-To: <1527261428-6662-3-git-send-email-Dave.Martin@arm.com>
References: <1527261428-6662-1-git-send-email-Dave.Martin@arm.com>
 <1527261428-6662-3-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180525152022.GE3255@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2018 at 04:17:08PM +0100, Dave Martin wrote:
> Stateful CPU architecture extensions may require the signal frame
> to grow to a size that exceeds the arch's MINSIGSTKSZ #define.
> However, changing this #define is an ABI break.
> 
> To allow userspace the option of determining the signal frame size
> in a more forwards-compatible way, this patch adds a new auxv entry
> tagged with AT_MINSIGSTKSZ, which provides the maximum signal frame
> size that the process can observe during its lifetime.
> 
> If AT_MINSIGSTKSZ is absent from the aux vector, the caller can
> assume that the MINSIGSTKSZ #define is sufficient.  This allows for
> a consistent interface with older kernels that do not provide
> AT_MINSIGSTKSZ.
> 
> The idea is that libc could expose this via sysconf() or some
> similar mechanism.
> 
> There is deliberately no AT_SIGSTKSZ.  The kernel knows nothing
> about userspace's own stack overheads and should not pretend to
> know.

Thanks, Dave.

Acked-by: Will Deacon <will.deacon@arm.com>

Will
