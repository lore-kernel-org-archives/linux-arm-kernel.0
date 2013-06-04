From: john.stultz@linaro.org (John Stultz)
Date: Mon, 03 Jun 2013 17:19:48 -0700
Subject: [PATCHv2 0/6] Make ARM's sched_clock generic + 64 bit friendly
In-Reply-To: <1370155183-31421-1-git-send-email-sboyd@codeaurora.org>
References: <1370155183-31421-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <51AD32A4.5070609@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2013 11:39 PM, Stephen Boyd wrote:
> This is mostly a resend of a patch series I sent a little over a month
> ago. I've reordered the patches so that John can pick up the first three
> and get a generic sched_clock layer without having to take the 64 bit
> patches. The last three patches add 64 bit support and move the architected
> timers on ARM64 and ARM to use it.


Yea, so from the initial look over it, I think I'm happy with queuing 
the first three patches, although I'd like to get some acks from arm 
folks on at least the first two, just so no one is surprised with it 
going through the -tip tree.

It looks like the arm64 bit stuff needs a few more iterations w/ 
Russell, so I'll not touch those.

We still have a ways to go to consolidate x86 into this (need to handle 
pv hooks), but it should provide a base to get some of the simpler 
arches sharing the same infrastructure.

Also I suspect we can maybe further combine this with the 
kernel/sched/clock.c code, but I think this is a good start for now.

thanks
-john
