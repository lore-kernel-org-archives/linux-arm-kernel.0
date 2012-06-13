From: apw@canonical.com (Andy Whitcroft)
Date: Wed, 13 Jun 2012 20:27:40 +0100
Subject: [RFC 1/4] ARM: topology: Add arch_scale_freq_power function
In-Reply-To: <1339591969.8980.30.camel@twins>
References: <1339502524-10265-1-git-send-email-vincent.guittot@linaro.org>
 <1339502524-10265-2-git-send-email-vincent.guittot@linaro.org>
 <1339591969.8980.30.camel@twins>
Message-ID: <20120613192740.GZ5878@dm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 02:52:49PM +0200, Peter Zijlstra wrote:
> On Tue, 2012-06-12 at 14:02 +0200, Vincent Guittot wrote:
> >         }
> >         smp_wmb();
> >  } 
> 
> You know what.. we should make checkpatch report an error for memory
> barriers that don't have a comment. 
> 
> I know this isn't added by this patch, but every time I see something
> like it I cry a little.

Actually if it was a new line, it would have been reported, at least in
theory:

    # check for memory barriers without a comment.
		    if ($line =~
    /\b(mb|rmb|wmb|read_barrier_depends|smp_mb|smp_rmb|smp_wmb|smp_read_barrier_depends)\(/)
    {
	if (!ctx_has_comment($first_line, $linenr)) {
	    CHK("MEMORY_BARRIER",
		"memory barrier without comment\n" . $herecurr);
	}
    }

-apw
