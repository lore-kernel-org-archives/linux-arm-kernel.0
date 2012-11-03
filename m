From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Sat, 03 Nov 2012 13:04:30 +0000
Subject: [PATCH 11/15] ARM: OMAP: timer: Interchange clksrc and clkevt
 for AM33XX
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EBFEA0E@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-12-git-send-email-vaibhav.bedia@ti.com>
 <5095037A.2020503@deeprootsystems.com>
 <B5906170F1614E41A8A28DE3B8D121433EBFEA0E@DBDE01.ent.ti.com>
Message-ID: <5095165E.10403@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

T
On 11/03/2012 12:47 PM, Bedia, Vaibhav wrote:
> Hi Kevin,
>
> On Sat, Nov 03, 2012 at 17:13:54, Kevin Hilman wrote:
>> On 11/02/2012 01:32 PM, Vaibhav Bedia wrote:
>>> AM33XX has only one usable timer in the WKUP domain.
>>> Currently the timer instance in WKUP domain is used
>>> as the clockevent and the timer in non-WKUP domain
>>> as the clocksource. The timer in WKUP domain can keep
>>> running in suspend from a 32K clock and hence serve
>>> as the persistent clock. To enable this, interchange
>>> the timers used as clocksource and clockevent for
>>> AM33XX.
>>
>> Doesn't this also mean that you won't get timer wakeups
>> in idle?  Or are you keeping the domain where the clockevent is
>> on during idle?
>>
>
> The lowest idle state that we are targeting will have MPU powered
> off with external memory in self-refresh mode. Peripheral domain
> with the clockevent will be kept on.

Is this a limitation of the hardware?  or the software?

Kevin

P.S.  I haven't yet made my way through the TRM, so I'll probably figure
this out when I read it, but having this summarized in the changelog would
be helpful since even after I read the TRM, I'll forget.  I'm saving the 
TRM
reading for entertainment on upcoming flight home from Linaro Connect.
