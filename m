From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Sat, 03 Nov 2012 13:41:54 +0000
Subject: [PATCH 12/15] ARM: OMAP: timer: Add suspend-resume callbacks
 for clockevent device
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EBFEA88@DBDE01.ent.ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-13-git-send-email-vaibhav.bedia@ti.com>
 <50950AC7.1030707@deeprootsystems.com>
 <B5906170F1614E41A8A28DE3B8D121433EBFEA88@DBDE01.ent.ti.com>
Message-ID: <50951F22.1070904@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/2012 01:17 PM, Bedia, Vaibhav wrote:
> On Sat, Nov 03, 2012 at 17:45:03, Kevin Hilman wrote:
>> On 11/02/2012 01:32 PM, Vaibhav Bedia wrote:
>>> From: Vaibhav Hiremath <hvaibhav@ti.com>
>>>
>>> The current OMAP timer code registers two timers -
>>> one as clocksource and one as clockevent.
>>> AM33XX has only one usable timer in the WKUP domain
>>> so one of the timers needs suspend-resume support
>>> to restore the configuration to pre-suspend state.
>>
>> The changelog describes "what", but doesn't answer "why?"
>>
>
> Sorry I'll try to take of this in the future.

Thanks.  Here's a general rule.  Assume you (or I) will be reading this
a year from now and will have forgotten the details.  The changelog then
serves as our long-term memory. :)

>>> commit adc78e6 (timekeeping: Add suspend and resume
>>> of clock event devices) introduced .suspend and .resume
>>> callbacks for clock event devices. Leverages these
>>> callbacks to have AM33XX clockevent timer which is
>>> in not in WKUP domain to behave properly across system
>>> suspend.
>>
>> You say it behaves properly without describing what improper
>> behavior is happening.
>>
>
> There are two issues. One is that the clockevent timer doesn't
> get idled which blocks PER domain transition. The next one is that
> the clockevent doesn't generate any further interrupts once the
> system resumes.

Please include both in the next rev of the changelog.

>We need to restore the pre-suspend configuration.
> I haven't tried but I guess we could have used the save and restore
> c timer registers here.

Yes, please try with that.  Won't that be necessary anyways for situations
where the powerdomain goes off?

Kevin
