From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 17 Feb 2017 11:01:10 +0000
Subject: [BUGFIX PATCH V2 0/3] kprobes/arm: Improve kprobes
 implementation on arm
In-Reply-To: <148711844284.5814.10387227824715177703.stgit@devbox>
References: <148711844284.5814.10387227824715177703.stgit@devbox>
Message-ID: <1487329270.3113.5.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2017-02-15 at 09:27 +0900, Masami Hiramatsu wrote:
> Hi,
> 
> Here is the 2nd version of the patches which improve kprobe
> on arm implementation (a kind of bugfix). Version 1 is here;
> 
> https://lkml.org/lkml/2017/2/13/538
> 
> In this version I didn't update the code, just update the
> patch description according to Tixy's comment and add his Ack.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (3):
>       kprobes/arm: Allow to handle reentered kprobe on single-stepping
>       kprobes/arm: Skip single-stepping in recursing path if possible
>       kprobes/arm: Fix the return address of multiple kretprobes
> 

Thanks for doing these. Am I correct in assuming we don't need to
consider these fixes urgent or critical? Only the first looks like it
could be serious, and the x86 fix for that is 3 years old and ARM has
gone without it all this time. So I'm guessing it's fine to wait for the
normal development process and deal with it after the about to open
merge window is completed?

If so, I propose that I put the patches in a branch for Russell to pull
later (unless he pipes up with objections or says otherwise). Meantime
I'll investigate the kprobes test failures I see (which actually looks
like cache/TLB issues and not test code problems after all).

BTW, I added the?ARM kernel list to the CC. I spotted you didn't add it
to you patch postings, which means people interested in ARM (other than
Russell) wouldn't have seen them.

Thanks

-- 
Tixy
