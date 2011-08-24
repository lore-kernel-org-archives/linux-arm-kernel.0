From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 24 Aug 2011 11:19:56 +0100
Subject: [PATCH v4 3/8] ARM: lib: add switch_stack function for safely
	changing stack
In-Reply-To: <alpine.LFD.2.00.1108232102430.20358@xanadu.home>
References: <1314136012-20533-1-git-send-email-will.deacon@arm.com>
	<1314136012-20533-4-git-send-email-will.deacon@arm.com>
	<alpine.LFD.2.00.1108232102430.20358@xanadu.home>
Message-ID: <20110824101956.GE2078@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 09:07:29PM -0400, Nicolas Pitre wrote:
> On Tue, 23 Aug 2011, Will Deacon wrote:
> 
> > When disabling the MMU, it is necessary to take out a 1:1 identity map
> > of the reset code so that it can safely be executed with and without
> > the MMU active. To avoid the situation where the physical address of the
> > reset code aliases with the virtual address of the active stack (which
> > cannot be included in the 1:1 mapping), it is desirable to change to a
> > new stack at a location which is less likely to alias.
> > 
> > This code adds a new lib function, switch_stack:
> > 
> > void switch_stack(void (*fn)(void *), void *arg, void *sp);
> > 
> > which changes the stack to point at the sp parameter, before invoking
> > fn(arg) with the new stack selected.
> > 
> > Signed-off-by: Dave Martin <dave.martin@linaro.org>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> For the implementation:
> 
> Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> However I think switch_stack() is too vague a name for what this 
> actually does.  Maybe something like call_with_stack(fn, arg, sp) is 
> more precise.

call_with_stack() soundslike a good name to me.

---Dave
