From: jdzheng@broadcom.com (Jiandong Zheng)
Date: Wed, 18 May 2011 16:38:18 -0700
Subject: [PATCH] ARM: bcmring: Add clkdev table in init_early
In-Reply-To: <20110518225214.GE21384@n2100.arm.linux.org.uk>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
	<E1QM1e8-0003ET-HK@rmk-PC.arm.linux.org.uk>
	<4DD2FF02.1020508@broadcom.com>
	<20110517232015.GC5913@n2100.arm.linux.org.uk>
	<4DD307E2.7010302@broadcom.com>
	<20110518154641.GK5913@n2100.arm.linux.org.uk>
	<4DD40965.9020202@broadcom.com>
	<20110518204242.GA21384@n2100.arm.linux.org.uk>
	<20110518223700.GC21384@n2100.arm.linux.org.uk>
	<4DD44C0C.1090907@broadcom.com>
	<20110518225214.GE21384@n2100.arm.linux.org.uk>
Message-ID: <4DD4586A.7000805@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/18/2011 3:52 PM, Russell King - ARM Linux wrote:
> On Wed, May 18, 2011 at 03:45:32PM -0700, Jiandong Zheng wrote:
>> On 5/18/2011 3:37 PM, Russell King - ARM Linux wrote:
>>> On Wed, May 18, 2011 at 09:42:42PM +0100, Russell King - ARM Linux wrote:
>>>> On Wed, May 18, 2011 at 11:01:09AM -0700, Jiandong Zheng wrote:
>>>>> ARM: bcmring: Move adding clkdev to init_early to make sure clkevent
>>>>> based on sp804 is initialized properly.
>>>>
>>>> Great, can you submit this to the patch system please?  Thanks.
>>>
>>> Erm, actually this patch is against your previous patch (as is the one
>>> which you submitted to the patch system) so it won't apply as-is.  It
>>> needs to be one which wil apply directly to mainline in this case please.
>>>
>> Hi Russell,
>>
>> And my previous patch is based on your set of patches to do common sp804
>> clock source. How should I submit mine?
>
> Can you provide a patch against mainline which moves the clkdev
> initialization to the init_early callback - and I'll then deal with
> fixing up my patches for that by placing it before my two bcmring
> patches.

Done.

>
>> Since I haven't had much experience with submitting patch so far, please
>> allow me to ask a question which may be asked many times: when should I
>> use patch system?
>
> When the patch has been reviewed and acked by people.  Note that things
> in this area will be changing because in the long run you should end
> up talking to the sub-arch group of people.
>
>> For example, I sent a couple of unrelated patches last week and seems no
>> one has problem with them since I don't see comments regarding them.
>> Should I submit them again through patch system or they will picked up
>> "automatically"?
>
> The debug-macros.S one seemed trivial enough, but the downside is that
> it impacts on our goal of showing a significant reduction of arch/arm...
> Since I'm fairly desperate to show as much of a reduction as possible
> this goes counter to my current direction.
>
> I think the other one was a build fix (?), and that should be fine.
>
