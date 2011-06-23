From: khilman@ti.com (Kevin Hilman)
Date: Thu, 23 Jun 2011 08:05:07 -0700
Subject: [PATCH 06/10] omap2+: Remove gptimer_wakeup for now
In-Reply-To: <20110620094846.GG23145@atomide.com> (Tony Lindgren's message of
	"Mon, 20 Jun 2011 02:48:46 -0700")
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092341.357.14183.stgit@kaulin> <4DFF1558.4020509@ti.com>
	<20110620094846.GG23145@atomide.com>
Message-ID: <87oc1obnbw.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Santosh Shilimkar <santosh.shilimkar@ti.com> [110620 02:35]:
>> On 6/20/2011 2:53 PM, Tony Lindgren wrote:
>> >This removes the support for setting the wake-up timer for debugging.
>> >
>> >Later on we can reserve gptimer1 for PM code only and have similar
>> >functionality.
>> >
>> >Signed-off-by: Tony Lindgren<tony@atomide.com>
>> >Reviewed-by: Kevin Hilman<khilman@ti.com>
>> >---
>> 
>> Kevin cleaned up this with a better patch.
>> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg50015.html
>> 
>> May be we can use that patch instead of this.
>
> The thing is that it's a omap specific debug interface.

What's wrong with OMAP-specific debug interfaces?   We have plenty of
them: clock, omap_mux and pm_debug.

> I'd rather just get rid of it until there's some generic way
> of doing it. 

Well, we won't have a truly generic way of doing it until we have a
generic way of doing HW timers.

The implementation is now mostly generic in the patch Santosh referened
above in that the timer programming is now done as part of the
clockevent code, and not external timer programming.

So now, the only thing OMAP-specific is the debugfs file used to trigger
it.

> Maybe Kevin can just carry it along in the PM branch for now?

I'd prefer to keep it in mainline as this is a very important feature
for the PM functionality already in mainline.

Kevin
