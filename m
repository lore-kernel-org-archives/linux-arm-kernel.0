From: santosh.shilimkar@ti.com (Santosh)
Date: Wed, 14 Sep 2011 22:52:38 +0530
Subject: [PATCH 13/25] OMAP4: PM: Add WakeupGen module as OMAP
	gic_arch_extn
In-Reply-To: <20110914171800.GO24252@atomide.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com>
	<20110913203616.GG24252@atomide.com>
	<CAMQu2gyYETPZRJu=4MWX6bULgmMaJb8MRwfhvURtOuyyWhLkAQ@mail.gmail.com>
	<20110914152116.GM24252@atomide.com> <4E70DB33.5070501@ti.com>
	<20110914170803.GN24252@atomide.com> <4E70E0CC.80300@ti.com>
	<20110914171800.GO24252@atomide.com>
Message-ID: <4E70E2DE.2030006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 September 2011 10:48 PM, Tony Lindgren wrote:
> * Santosh<santosh.shilimkar@ti.com>  [110914 09:40]:
>> On Wednesday 14 September 2011 10:38 PM, Tony Lindgren wrote:
>>> * Santosh<santosh.shilimkar@ti.com>   [110914 09:16]:
>>>
>>> Thanks for the clarification. It seems to me the spec is most likely
>>> wrong as we've had the GIC working for over two years now without
>>> doing anything with the wakeup gen registers :)
>>>
>> It's working because CPU clockdomain are never put under HW
>> supervised mode and they are kept in force wakeup. Clock-domain
>> never idles on mainline code. PM series will put the clock-domains
>> under HW supervison as needed to achieve any low power states and
>> then all sorts of corner cases will come out.
>
> But again the wakeup gen triggers only do something when hitting
> idle. There should be no use for them during runtime, right?
>
You missed my point in the description. Clockdomain inactive
doesn't depend on idle or WFI execution. Under HW supervison
CPU clock domain can get into inactive when CPU is stalled and
waiting for a read response from slow interconnect.

One thing for sure. Designers has chosen a wrong name to this
IP. Wakeugen apears like needed only for low power wakeup which
not seems to be entirely correct as per specs

Regards
Santosh
