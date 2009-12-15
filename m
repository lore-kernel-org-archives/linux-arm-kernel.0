From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 15 Dec 2009 16:30:13 +0100
Subject: [PATCH 5/5] arm/perfevents: implement perf event support for ARMv6
In-Reply-To: <20091215151903.GP4141@wear.picochip.com>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-2-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-3-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-4-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-5-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-6-git-send-email-jamie.iles@picochip.com>
	<20091215150205.GO4141@wear.picochip.com>
	<000201ca7d98$012826b0$03787410$@deacon@arm.com>
	<20091215151903.GP4141@wear.picochip.com>
Message-ID: <1260891013.4165.466.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2009-12-15 at 15:19 +0000, Jamie Iles wrote:
> Another problem with mpcore support is that
> with the v6 performance counters, you can't disable a single event
> counter. 

Can you program them with a non-counting event?

On x86 there's various ways of doing that, either by selecting an event
that simply doesn't count (cache-misses with 0 MESI mask), or by telling
it to mask both user and kernel event.
