From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 30 Jul 2013 10:47:15 +0200
Subject: Enable arm_global_timer for Zynq brakes boot
In-Reply-To: <8d56935e-2a20-46c7-b80a-f779572dd839@CO1EHSMHS014.ehs.local>
References: <20130717210417.GP13667@xsjandreislx>
 <51E72DCA.9070500@codeaurora.org>
 <f5b76049-7e5b-4dd0-9863-19cfd1d599b9@TX2EHSMHS006.ehs.local>
 <51E7435B.3060605@codeaurora.org>
 <ff4d40be-7177-4a55-ab2f-dff11fa18642@DB9EHSMHS009.ehs.local>
 <51ED8DF2.60600@codeaurora.org> <20130722201348.GI453@xsjandreislx>
 <0735ab8c-0f80-4b64-b2b2-8d4553482c2a@CO9EHSMHS013.ehs.local>
 <51F66565.7010600@linaro.org>
 <8d56935e-2a20-46c7-b80a-f779572dd839@CO1EHSMHS014.ehs.local>
Message-ID: <51F77D93.4030505@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2013 02:03 AM, S?ren Brinkmann wrote:
> Hi Daniel,
> 
> On Mon, Jul 29, 2013 at 02:51:49PM +0200, Daniel Lezcano wrote:
> (snip)
>>
>> the CPUIDLE_FLAG_TIMER_STOP flag tells the cpuidle framework the local
>> timer will be stopped when entering to the idle state. In this case, the
>> cpuidle framework will call clockevents_notify(ENTER) and switches to a
>> broadcast timer and will call clockevents_notify(EXIT) when exiting the
>> idle state, switching the local timer back in use.
> 
> I've been thinking about this, trying to understand how this makes my
> boot attempts on Zynq hang. IIUC, the wrongly provided TIMER_STOP flag
> would make the timer core switch to a broadcast device even though it
> wouldn't be necessary. But shouldn't it still work? It sounds like we do
> something useless, but nothing wrong in a sense that it should result in
> breakage. I guess I'm missing something obvious. This timer system will
> always remain a mystery to me.
> 
> Actually this more or less leads to the question: What is this
> 'broadcast timer'. I guess that is some clockevent device which is
> common to all cores? (that would be the cadence_ttc for Zynq). Is the
> hang pointing to some issue with that driver?

If you look at the /proc/timer_list, which timer is used for broadcasting ?

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
