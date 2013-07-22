From: rric@kernel.org (Robert Richter)
Date: Mon, 22 Jul 2013 15:56:39 +0200
Subject: [PATCH] ARM: Fix r7/r11 confusion when CONFIG_THUMB2_KERNEL=y
In-Reply-To: <20130721213753.GA29879@mudshark.cambridge.arm.com>
References: <1373685501-1620-1-git-send-email-jld@mozilla.com>
 <20130715135420.GG10000@mudshark.cambridge.arm.com>
 <20130720044655.GC9433@mozilla.com>
 <20130721213753.GA29879@mudshark.cambridge.arm.com>
Message-ID: <20130722135639.GA6927@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.07.13 22:37:53, Will Deacon wrote:
> Ok, I think I'm with you now. I also think that a better solution would be
> to try and limit the r7/fp confusion to one place, perhaps behind something
> like:
> 
> void arm_get_current_stackframe(struct pt_regs *regs, struct stackframe *frame);

In unwind_backtrace() there is already common code to do this and also
to get it from a task_struct. This could be ripped out. I would prefer
then the following function:

 void init_stackframe(struct stackframe *frame, struct pt_regs *regs,
      		      struct task_struct *tsk)

-Robert
