From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 20 Jun 2011 20:40:45 +0530
Subject: [RFC PATCH] ARM: smp: Fix the CPU hotplug race with scheduler.
In-Reply-To: <20110620150140.GM2082@n2100.arm.linux.org.uk>
References: <20110620095053.GA2082@n2100.arm.linux.org.uk>
	<20110620101438.GD2082@n2100.arm.linux.org.uk>
	<4DFF20B3.7010209@ti.com>
	<20110620104415.GF2082@n2100.arm.linux.org.uk>
	<4DFF255E.5030308@ti.com>
	<20110620111336.GG2082@n2100.arm.linux.org.uk>
	<4DFF2E37.8030602@ti.com>
	<20110620114019.GH2082@n2100.arm.linux.org.uk>
	<20110620142338.GL2082@n2100.arm.linux.org.uk>
	<4DFF5F29.2000904@ti.com>
	<20110620150140.GM2082@n2100.arm.linux.org.uk>
Message-ID: <4DFF62F5.2080802@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/20/2011 8:31 PM, Russell King - ARM Linux wrote:
> On Mon, Jun 20, 2011 at 08:24:33PM +0530, Santosh Shilimkar wrote:
>> I am away from my board now. Will test this change.
>> btw, the online-active race is still open even with this patch close
>> and should be fixed.
>
> I have yet to see any evidence of that race - I've been running your
> test loop for about an hour so far on Versatile Express and nothing
> yet.
>
In that case my script was just exposing the calibrate() code race
condition.

> That's not to say that we shouldn't wait for the active mask to become
> true before calling schedule(), but I don't think its as big a deal as
> you're suggesting it is.
I am not expert to really trigger that exact race online-to-active but
am sure the race needs to be fixed.

May be Thomas can suggest a test-case to expose that race. From
his fix for x86, it appeared that the race was indeed hit in some
sequence.

Regards,
Santosh
