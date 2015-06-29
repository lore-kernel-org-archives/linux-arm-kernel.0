From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Mon, 29 Jun 2015 14:12:48 -0700
Subject: [PATCH] keystone: adds cpu_die implementation
In-Reply-To: <559191E0.4080808@ti.com>
References: <1435600352-32733-1-git-send-email-vitalya@ti.com>
 <20150629175223.GC19863@leverpostej> <559191E0.4080808@ti.com>
Message-ID: <5591B4D0.8090204@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 6/29/15 11:43 AM, Vitaly Andrianov wrote:
>
>
> On 06/29/2015 01:52 PM, Mark Rutland wrote:
>> On Mon, Jun 29, 2015 at 06:52:32PM +0100, Vitaly Andrianov wrote:
>>> This commit add cpu_die implementation
>>>
>>> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
>>> ---
>>>
>>> The discussion of the "keystone: psci: adds cpu_die implementation"
>>> commit
>>> shows that if PCSI is enabled platform code doesn't need that
>>> implementation
>>> at all. Having PSCI commands in DTB should be sufficient. Unfortunately
>>> Keystone with LPAE enable requires some additional development.
>>
>> I don't follow.
>>
>> What do you need to implement for LPAE?
> Hi Mark,
>
> The Keystone platform needs to set ttbr1 when it boots secondary core.
> It is done in the keystone_smp_secondary_initmem(), which is
> .smp_secondary_init member of the keystone_smp_ops. I couldn't find a
> way how I can add similar function to psci_smp_ops.
>
> Do you have any idea?
>
>>
>> Why not implement that rather than adding more platform code that you'll
>> likely want to remove later anyway?
>
> If I can solve the above problem, I will not add this code.
>
This problem is already solved. :-)

After [1], there is no longer need to fiddle with TTBR1 setup
for secondary bringup.  I believe its already in RMK's queue and it
should show up in linus's tree after 4.2 merge window.


Regards,
Santosh

[1] http://www.spinics.net/lists/arm-kernel/msg416129.html
