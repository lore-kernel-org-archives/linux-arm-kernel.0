From: kapilh@broadcom.com (Kapil Hali)
Date: Fri, 6 Nov 2015 17:39:43 +0530
Subject: [PATCH RESEND 0/4] SMP support for Broadcom NSP
In-Reply-To: <20151105093443.GO8644@n2100.arm.linux.org.uk>
References: <1446702681-45339-1-git-send-email-kapilh@broadcom.com>
 <20151105093443.GO8644@n2100.arm.linux.org.uk>
Message-ID: <563C9887.5090406@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/5/2015 3:04 PM, Russell King - ARM Linux wrote:
> On Thu, Nov 05, 2015 at 12:51:17AM -0500, Kapil Hali wrote:
>> Hi,
>>
>> This series adds SMP support for Broadcom's Northstar Plus SoC.
>>
>> There are similar SMP enablement methods for many ARMv7 bsed SoCs.
>> BCM NSP SoC, has a typical such mechanism - after power-on, the
>> secondary core is held in a standby state, primary core provides a
>> startup address for the secondary core and wakes it up. Booting of
>> the secondary core is serialized using pen_release global variable.
> 
> Why do you need the pen_release stuff?  The above implies that you
> have only one secondary core, and you can control when it comes out
> of standby state.
> 
We can initiate a wake-up of the secondary core. I tested the changes
without pen_release method and it works. However, as I understand, I
think there is no other way for the primary core to know if the 
secondary core has come out of standby state other than pen_release
mechanism. When there is no other method available, will not 
smp_boot_secondary() always return successful wake-up of the
secondary core?

> Please, don't assume that the pen_release stuff is any kind of recommended
> or standardised system.  It isn't.  It's a hack for ARMs evaluation
> platforms.
> 
Got it. As pen_release is forbidden, I will change the SMP mechanism
to remove pen_release method in the new patch set.

Thanks,
Kapil
