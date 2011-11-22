From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 22 Nov 2011 13:56:27 +0000
Subject: [PATCH 2/4] ARM: extract out insn generation code from ftrace
In-Reply-To: <CAH+eYFBz_aEeC3DwGF2mdpVepburzCBJqD0n1LFjL1y5dqOXHw@mail.gmail.com>
References: <1321888429-3519-1-git-send-email-rabin@rab.in>
 <1321888429-3519-2-git-send-email-rabin@rab.in>
 <20111122120252.GE2066@localhost.localdomain>
 <CAH+eYFBz_aEeC3DwGF2mdpVepburzCBJqD0n1LFjL1y5dqOXHw@mail.gmail.com>
Message-ID: <20111122135627.GH2066@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 07:02:13PM +0530, Rabin Vincent wrote:
> On Tue, Nov 22, 2011 at 17:32, Dave Martin <dave.martin@linaro.org> wrote:
> > On Mon, Nov 21, 2011 at 08:43:47PM +0530, Rabin Vincent wrote:
> >> ?static int ftrace_modify_code(unsigned long pc, unsigned long old,
> >> @@ -256,7 +203,7 @@ static int __ftrace_modify_caller(unsigned long *callsite,
> >> ?{
> >> ? ? ? unsigned long caller_fn = (unsigned long) func;
> >> ? ? ? unsigned long pc = (unsigned long) callsite;
> >> - ? ? unsigned long branch = ftrace_gen_branch(pc, caller_fn, false);
> >> + ? ? unsigned long branch = arm_gen_branch(pc, caller_fn);
> >> ? ? ? unsigned long nop = 0xe1a00000; /* mov r0, r0 */
> >
> > Does this code get used in Thumb-2 kernels? ?So far as I can tell, this
> > code is used... but it looks like it shouldn't work, due to the ARM
> > specifics.
> 
> It's not used on Thumb-2.  This is only used by the function graph
> tracer and that depends on !THUMB2_KERNEL.

I assume there's no special reason why this doesn't work with a Thumb-2
kernel, other than that it simply hasn't implemented yet?

Are there any particular problems blocking this?

Cheers
---Dave
