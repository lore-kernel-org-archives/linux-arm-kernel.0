From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Dec 2010 16:25:52 +0000
Subject: [PATCH 01/16] ARM: Remove dependency of plat-orion time code
	on mach directory includes.
In-Reply-To: <20101215020228.GT15575@mail.wantstofly.org>
References: <cover.1292377339.git.buytenh@wantstofly.org>
	<20101215020228.GT15575@mail.wantstofly.org>
Message-ID: <20101215162552.GD9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 15, 2010 at 03:02:28AM +0100, Lennert Buytenhek wrote:
> This patch makes the various mach dirs that use the plat-orion time
> code pass in timer and bridge addresses explicitly, instead of having
> plat-orion get those values by including a mach dir include file --
> the latter mechanism is problematic if you want to support multiple
> ARM platforms in the same kernel image.

I'd prefer you to leave sched_clock() alone - I'm preparing a patch
series which replaces all sched_clock() implementations with something
that fully satisfies the scheduler requirements.

The first step of that is fixing the clocksource mess, which I recently
posted.  I have a currently set of three possible further resolutions
which meet the scheduler requirements with varying overheads - some with
more and some with less overhead in the fast path than the current
cnt32_to_63 + multiply + do_div.
