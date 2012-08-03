From: koen@dominion.thruhere.net (Koen Kooi)
Date: Fri, 3 Aug 2012 10:30:52 +0200
Subject: [PATCH 1/3] ARM: OMAP: timer: allow gp timer clock-event to be
 used on both cpus
In-Reply-To: <76308EBE-F802-411A-973A-7BBC7575FE5A@dominion.thruhere.net>
References: <1333114048-26136-1-git-send-email-santosh.shilimkar@ti.com>
 <1333114048-26136-2-git-send-email-santosh.shilimkar@ti.com>
 <501B7AE6.8080405@gmail.com>
 <76308EBE-F802-411A-973A-7BBC7575FE5A@dominion.thruhere.net>
Message-ID: <BDB76D4F-31B0-47D0-B1A1-64A743D091D3@dominion.thruhere.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Op 3 aug. 2012, om 09:21 heeft Koen Kooi <koen@dominion.thruhere.net> het volgende geschreven:

> 
> Op 3 aug. 2012, om 09:16 heeft Daniel Mack <zonque@gmail.com> het volgende geschreven:
> 
>> On 30.03.2012 15:27, Santosh Shilimkar wrote:
>>> For coupled cpuidle to work when both cpus are active, it needs a global timer
>>> that can handle events for both cpus.  This timer is used as the broadcast
>>> clock-event when the per-cpu timer hardware stop in low power states.
>>> Set the cpumask of clockevent_gpt to all cpus, set the rating correctly, and
>>> set the irq to allow the clockevent core to determine the affinity of the
>>> timer.
>> 
>> These patches made it to mainline now, shortly befor 3.6-rc1, and it
>> breaks boot on my AM33xx board.
>> 
>> Once I revert 1/3, the board boots again but crashes with the Ooops
>> below. With the entire series reverted, everything works again as
>> expected. Any idea?
>> 
>> The upstream commit ids are
>> 
>> 11d6ec2e "ARM: OMAP: timer: allow gp timer clock-event to be used on
>> both cpus"
>> 5b4d5bcc "ARM: OMAP4: CPUidle: add synchronization for coupled idle states"
>> b93d70ae "ARM: OMAP4: CPUidle: Open broadcast clock-event device."
> 
> I've had boot problems with cpuidle enabled as well, what happens if you disable it? Is the revert still needed in that case? 

To answer my own question: No, the reverts aren't needed if you disable cpuidle.
