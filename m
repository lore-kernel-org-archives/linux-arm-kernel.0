From: khilman@ti.com (Kevin Hilman)
Date: Mon, 27 Jun 2011 09:30:08 -0700
Subject: [PATCH 06/10] omap2+: Remove gptimer_wakeup for now
In-Reply-To: <20110627080804.GG23145@atomide.com> (Tony Lindgren's message of
	"Mon, 27 Jun 2011 01:08:05 -0700")
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092341.357.14183.stgit@kaulin> <4DFF1558.4020509@ti.com>
	<20110620094846.GG23145@atomide.com> <87oc1obnbw.fsf@ti.com>
	<4E035835.50405@ti.com> <20110627080804.GG23145@atomide.com>
Message-ID: <87hb7bdypb.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Santosh Shilimkar <santosh.shilimkar@ti.com> [110623 08:09]:
>> On 6/23/2011 8:35 PM, Kevin Hilman wrote:
>> >Tony Lindgren<tony@atomide.com>  writes:
>> >
>> >So now, the only thing OMAP-specific is the debugfs file used to trigger
>> >it.
>> >
>> >>Maybe Kevin can just carry it along in the PM branch for now?
>> >
>> >I'd prefer to keep it in mainline as this is a very important feature
>> >for the PM functionality already in mainline.
>> >
>> I agree with Kevin and that's what have been saying from begining when
>> we decided to drop this feature. The new patch from Kevin is already
>> doing this in more generic way than that was before.
>
> To me Kevin's later patch makes more sense, but still has few issues:
>
> - It keeps the dependency between PM debug code and sys_timer code.
>   That's yet another artificial blocker for making PM code a loadable
>   module. We really don't want to export anything from the sys_timer code.
>
> - The interface for programming a wake-up timer should be Linux generic,
>   not omap specific.
>
> Further, it's a CONFIG_PM_DEBUG patch. So that code should not be
> in the mainline kernel.

Huh?  

Please clarify why PM debug code shouldn't be in mainline?

Kevin
