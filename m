From: qiyaoltc@gmail.com (Yao Qi)
Date: Mon, 16 Jan 2017 11:34:39 +0000
Subject: [RFC PATCH 06/10] arm64/sve: Disallow VL setting for individual
 threads by default
In-Reply-To: <1484220369-23970-7-git-send-email-Dave.Martin@arm.com>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
 <1484220369-23970-7-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170116113439.GF28060@E107787-LIN>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17-01-12 11:26:05, Dave Martin wrote:
> General-purpose code in userspace is not expected to work correctly
> if multiple threads are allowed to run concurrently with different
> vector lengths in a single process.
> 
> This patch adds an explicit flag PR_SVE_SET_VL_THREAD to request
> this behaviour.  Without the flag, vector length setting is
> permitted only for a single-threaded process (which matches the
> expected usage model of setting the vector length at process
> startup).

Hi Dave,
PR_SVE_SET_VL_THREAD can be arch-independent, IMO, because prctl
needs a scope.  Looks some of them are system-wide, some of them are
about threads within the same process (like, PR_MPX_ENABLE_MANAGEMENT).
IOW, PR_SVE_SET_VL_THREAD can be general flag, to indicate the scope
of each new ptrcl command is per-thread.

I happen to see PR_SET_FP_MODE in man pages, which is about setting
FP register modes in runtime.  It is a little similar to setting VL in
this patch.  However the doc doesn't mention the effect or the scope
of this command.

-- 
Yao (??)
