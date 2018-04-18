From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 Apr 2018 15:14:13 +0100
Subject: [PATCH] arm64: signal: don't force known signals to SIGKILL
In-Reply-To: <20180416154501.56872-1-mark.rutland@arm.com>
References: <20180416154501.56872-1-mark.rutland@arm.com>
Message-ID: <20180418141412.xoi537lnkdw2vq6i@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 04:45:01PM +0100, Mark Rutland wrote:
> Since commit:
> 
>   a7e6f1ca90354a31 ("arm64: signal: Force SIGKILL for unknown signals in force_signal_inject")
> 
> ... any signal which is not SIGKILL will be upgraded to a SIGKILL be
> force_signal_inject(). This includes signals we do expect, such as
> SIGILL triggered by do_undefinstr().
> 
> Fix the check to use a logical AND rather than a logical OR, permitting
> signals whose layout is SIL_FAULT.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Fixes: a7e6f1ca90354a31 ("arm64: signal: Force SIGKILL for unknown signals in force_signal_inject")
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dave Martin <dave.martin@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Queued for 4.17-rc2. Thanks.

-- 
Catalin
