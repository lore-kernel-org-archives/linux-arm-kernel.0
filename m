From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 15 Dec 2010 11:59:58 -0500 (EST)
Subject: [PATCH 01/16] ARM: Remove dependency of plat-orion time code on
	mach directory includes.
In-Reply-To: <20101215162552.GD9937@n2100.arm.linux.org.uk>
References: <cover.1292377339.git.buytenh@wantstofly.org>
	<20101215020228.GT15575@mail.wantstofly.org>
	<20101215162552.GD9937@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1012151157270.10437@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Dec 2010, Russell King - ARM Linux wrote:

> On Wed, Dec 15, 2010 at 03:02:28AM +0100, Lennert Buytenhek wrote:
> > This patch makes the various mach dirs that use the plat-orion time
> > code pass in timer and bridge addresses explicitly, instead of having
> > plat-orion get those values by including a mach dir include file --
> > the latter mechanism is problematic if you want to support multiple
> > ARM platforms in the same kernel image.
> 
> I'd prefer you to leave sched_clock() alone - I'm preparing a patch
> series which replaces all sched_clock() implementations with something
> that fully satisfies the scheduler requirements.
> 
> The first step of that is fixing the clocksource mess, which I recently
> posted.  I have a currently set of three possible further resolutions
> which meet the scheduler requirements with varying overheads - some with
> more and some with less overhead in the fast path than the current
> cnt32_to_63 + multiply + do_div.

OK -- Lennert asked me to carry this patch in the orion Git tree but 
I'll hold it back for now.

Looking forward to your sched_clock patch series.


Nicolas
