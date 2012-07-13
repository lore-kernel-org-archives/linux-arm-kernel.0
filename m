From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Fri, 13 Jul 2012 11:16:41 +0900
Subject: [PATCH v2 2/2] ARM: delay: allow timer-based delay implementation
 to be selected
In-Reply-To: <4FFEFDE3.5000403@codeaurora.org>
References: <1340991231-17682-1-git-send-email-will.deacon@arm.com>
 <1340991231-17682-3-git-send-email-will.deacon@arm.com>
 <4FFE7DB2.4040702@renesas.com>
 <20120712084432.GA2816@mudshark.cambridge.arm.com>
 <4FFE9A69.3060301@renesas.com> <4FFEFDE3.5000403@codeaurora.org>
Message-ID: <4FFF8509.2050302@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/13/2012 1:40 AM, Stephen Boyd wrote:
>>>> As a result, actual udelay()s may be toooo long than expected, in
>>>> particular udelay()s used between init_current_timer_delay() and
>>>> calibrate_delay().  It's unlikely be short, as the frequency of a
>>>> counter for read_current_timer is typically slower than CPU frequency.
>>> Surely using udelay before calibrate_delay_loop has been called is a
>>> fundamental error?
>> Got it.  I'm just not confident about disallowing early use of udelay().
>>
> 
> I don't think it's an error. Instead you get a very large delay, similar
> to what would happen if you called udelay() before calibrate_delay()
> anyway (see the comment in init/main.c above loops_per_jiffy).

Thanks, so I'd set up loops_per_jiffy early, along with lpj_fine in
init_current_timer_delay().

As a matter of fact, I do have early use of udelay()s in my tree :-)
Will give it a try for some time.
-- 
Shinya Kuribayashi
Renesas Electronics
