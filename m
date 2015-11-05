From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Thu, 05 Nov 2015 21:25:30 +0100
Subject: [PATCH RESEND 0/4] SMP support for Broadcom NSP
In-Reply-To: <20151105093443.GO8644@n2100.arm.linux.org.uk>
References: <1446702681-45339-1-git-send-email-kapilh@broadcom.com>
 <20151105093443.GO8644@n2100.arm.linux.org.uk>
Message-ID: <563BBB3A.6010605@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2015 10:34 AM, Russell King - ARM Linux wrote:
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
> Please, don't assume that the pen_release stuff is any kind of recommended
> or standardised system.  It isn't.  It's a hack for ARMs evaluation
> platforms.
> 

I tried to remove the pen code because I also thought/hoped that it is
useless, but the 2. CPU did not boot any more after I removed it. I do
not know the internals of SoC, but it looks like this is needed.

I described it here:
http://www.spinics.net/lists/arm-kernel/msg452178.html

I removed this comparison and the jump afterwards ("cmp     r7, r0") and
the 2. CPU did not boot any more. Is this pen stuff some kind of
workaround for some bug in the silicon?

Hauke
