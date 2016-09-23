From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 23 Sep 2016 10:04:31 +0800
Subject: [PATCH] clocksource/drivers/ti-32k: Prevent ftrace recursion
In-Reply-To: <alpine.DEB.2.20.1609221555590.5599@nanos>
References: <20160922075621.3725-1-jszhang@marvell.com>
 <alpine.DEB.2.20.1609221555590.5599@nanos>
Message-ID: <20160923100431.6cf2c88f@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Thu, 22 Sep 2016 15:58:03 +0200 Thomas Gleixner wrote:

> On Thu, 22 Sep 2016, Jisheng Zhang wrote:
> 
> > Currently ti-32k can be used as a scheduler clock. We properly marked
> > omap_32k_read_sched_clock() as notrace but we then call another
> > function ti_32k_read_cycles() that _wasn't_ notrace.
> > 
> > Having a traceable function in the sched_clock() path leads to a
> > recursion within ftrace and a kernel crash.  
> 
> Kernel crash? Doesn't ftrace core prevent recursion?

a recent similar issue:

http://www.spinics.net/lists/arm-kernel/msg533480.html

Thanks,
Jisheng
