From: will.deacon@arm.com (Will Deacon)
Date: Sat, 27 Nov 2010 21:12:11 +0000
Subject: [PATCH 0/4] ARM: hw_breakpoint: fixes and improvements
In-Reply-To: <20101127123939.GA5998@n2100.arm.linux.org.uk>
References: <1290704899-13051-1-git-send-email-will.deacon@arm.com>
	<20101127123939.GA5998@n2100.arm.linux.org.uk>
Message-ID: <1290892331.30176.4.camel@jazzbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Sat, 2010-11-27 at 12:39 +0000, Russell King - ARM Linux wrote:
> On Thu, Nov 25, 2010 at 05:08:15PM +0000, Will Deacon wrote:
> > All feedback welcome!
> 
> While in the subject of fixes, sparse seems to have a problem with
> hw_breakpoint's usage of percpu stuff:
> 
[...]

This appears to be because I access something declared as perf_event *[]
using something of type perf_event **. I plan on re-rolling these fixes
anyway as I found a problem with CONFIG_PREEMPT, so I'll add the
necessary casts to silence sparse to the series.

> perf_event.c seems to also have problems too:
> 
I don't think you've pulled my perf-split branch yet, so if you hold
fire on that I'll add some fixes to get rid of these warnings [I think I
noticed one of the issues before] and send another pull request in the
week.

Thanks!

Will
