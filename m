From: mgorman@suse.de (Mel Gorman)
Date: Thu, 26 Mar 2015 12:30:29 +0000
Subject: [PATCH] ARM: print cma-reserved pages from show_mem
In-Reply-To: <20150326114612.GD8656@n2100.arm.linux.org.uk>
References: <1423092164-9145-1-git-send-email-gregory.0xf0@gmail.com>
 <54D40DAF.4080609@codeaurora.org>
 <CADtm3G7ROX4CrxSKRvTKcjqCiX=uJQZ=Q5izH8pS61z4jfumLg@mail.gmail.com>
 <54D534FB.1090101@codeaurora.org>
 <CADtm3G7CUYUUbmTrWiudQ5j-wX9hu86Ox8TkB+FnXwEvjb=xeg@mail.gmail.com>
 <20150210113230.GJ8656@n2100.arm.linux.org.uk>
 <CADtm3G64rPf7O76xUbLwqsqTkJxdGJMT9sHj810xPuThDA0ddg@mail.gmail.com>
 <20150326114612.GD8656@n2100.arm.linux.org.uk>
Message-ID: <20150326123028.GM4701@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 11:46:12AM +0000, Russell King - ARM Linux wrote:
> <SNIP>
> 
> Looking at Mel's commit, I don't see a reason why we couldn't use that
> solution - it gets rid of walking the page array, which has been fraught
> in the past due to ARM having platforms which have holes in their
> physical memory.
> 
> We could try that solution - I don't see much downside to it.  Most of
> that information is as debug information for MM stuff anyway, and IMHO

>From an MM perspective, I can tell you that the information is close to
useless for debugging anything. It's why I ditched it in that commit and
AFAIK, no one has ever cared.

> 8<===
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> Subject: [PATCH] ARM: switch to use the generic show_mem() implementation
> 
> Switch ARM to use the generic show_mem() implementation, which displays
> the statistics from the mm zone rather than walking the page arrays.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

If this builds, boots and sysrq-m works as expected then for what it's worth

Acked-by: Mel Gorman <mgorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
