From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 2 Oct 2013 13:14:44 -0400
Subject: [PATCH] sched_clock: fix postinit no sched_clock function check
In-Reply-To: <20131002170917.GB30298@mudshark.cambridge.arm.com>
References: <1380732928-13897-1-git-send-email-santosh.shilimkar@ti.com>
 <20131002170917.GB30298@mudshark.cambridge.arm.com>
Message-ID: <524C5484.5000601@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 October 2013 01:09 PM, Will Deacon wrote:
> On Wed, Oct 02, 2013 at 05:55:28PM +0100, Santosh Shilimkar wrote:
>> The sched_clock code uses 2 levels of function pointers, sched_clock_func()
>> and read_sched_clock() but the no sched_clock check in postinit() just
>> checks read_sched_clock().
>>
>> This leads to kernel falling back to jiffy based sched clock even in
>> presence of sched_clock_func() which is not desirable.
>>
>> Fix the postinit() check to avoid the issue. Probably the issue is hidden
>> so far on most of the arm SOCs because of already existing sched_clock
>> registrations apart from arch_timer sched_clock. One can reproduce the
>> issue by just have arch_timer as sched_clock
> 
> Isn't this just an issue with the arch timer driver not calling
> setup_sched_clock? Instead, we munge around with sched_clock_func directly,
> which doesn't appear to be the way anybody else deals with this.
> 
I thought about that option as well but was not sure since even in that case
the check is not complete. We just ensure that function is popullated.

> I'm not sure of the history though, so perhaps there's a reason for this...
> 
Am curious as well.

Regards,
Santosh
