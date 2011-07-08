From: khilman@ti.com (Kevin Hilman)
Date: Fri, 08 Jul 2011 07:19:56 -0700
Subject: [PATCH v4 4/7] OMAP2+: PM: idle clkdms only if already in idle
In-Reply-To: <alpine.DEB.2.00.1107071636540.2647@utopia.booyaka.com> (Paul
	Walmsley's message of "Thu, 7 Jul 2011 16:37:26 -0600 (MDT)")
References: <1309555626-22608-1-git-send-email-b-cousson@ti.com>
	<1309555626-22608-5-git-send-email-b-cousson@ti.com>
	<alpine.DEB.2.00.1107071636540.2647@utopia.booyaka.com>
Message-ID: <87sjqgc0s3.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Walmsley <paul@pwsan.com> writes:

> cc'ing Kevin, since this touches mach-omap2/pm.c - an ack would be great  
> if you have the chance
>
> On Fri, 1 Jul 2011, Benoit Cousson wrote:
>
>> From: Rajendra Nayak <rnayak@ti.com>
>> 
>> The omap_set_pwrdm_state function forces clockdomains
>> to idle, without checking the existing idle state
>> programmed, instead based solely on the HW capability
>> of the clockdomain to support idle.
>> This is wrong and the clockdomains should be idled
>> post a state_switch *only* if idle transitions on the
>> clockdomain were already enabled.
>> 
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>

Acked-by: Kevin Hilman <khilman@ti.com>

> Thanks, this patch has been queued for 3.1 at 
> git://git.pwsan.com/linux-2.6 in the 'powerdomain_fixes_3.1' branch.
>
>
> - Paul
