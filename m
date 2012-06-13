From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 13 Jun 2012 23:51:21 +0200
Subject: [RFC 1/4] ARM: topology: Add arch_scale_freq_power function
In-Reply-To: <20120613192740.GZ5878@dm>
References: <1339502524-10265-1-git-send-email-vincent.guittot@linaro.org>
 <1339502524-10265-2-git-send-email-vincent.guittot@linaro.org>
 <1339591969.8980.30.camel@twins> <20120613192740.GZ5878@dm>
Message-ID: <1339624281.8980.73.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-06-13 at 20:27 +0100, Andy Whitcroft wrote:

> Actually if it was a new line, it would have been reported, at least in
> theory:
> 
>     # check for memory barriers without a comment.
> 		    if ($line =~
>     /\b(mb|rmb|wmb|read_barrier_depends|smp_mb|smp_rmb|smp_wmb|smp_read_barrier_depends)\(/)
>     {
> 	if (!ctx_has_comment($first_line, $linenr)) {
> 	    CHK("MEMORY_BARRIER",
> 		"memory barrier without comment\n" . $herecurr);
> 	}
>     }

Oh sweet, we already have something for that.. But yeah I'd promote that
CHK to something stronger like Joe said. Maybe even error. Memory
barriers are magic, not adding proper comments should be a capital
offense. 
