From: pawelo@king.net.pl (Paul Osmialowski)
Date: Wed, 1 Jul 2015 10:42:07 +0200 (CEST)
Subject: [PATCH v2 4/9] arm: twr-k70f120m: timer driver for Kinetis SoC
In-Reply-To: <alpine.DEB.2.11.1507010944580.3916@nanos>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
 <1435667250-28299-5-git-send-email-pawelo@king.net.pl>
 <alpine.DEB.2.11.1507010944580.3916@nanos>
Message-ID: <alpine.LNX.2.00.1507011031050.9009@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Wed, 1 Jul 2015, Thomas Gleixner wrote:

>> +		clockevents_register_device(
>> +				&kinetis_clockevent_tmrs[chan].evtdev);
>> +
>> +		kinetis_pit_init(&kinetis_clockevent_tmrs[chan],
>> +						(rate / HZ) - 1);
>> +		kinetis_pit_enable(&kinetis_clockevent_tmrs[chan], 1);
>
> No point doing this. The core code has invoked the set_periodic call
> back via clockevents_register_device() already.
>

As I removed this kinetis_pit_enable() line, the timer did not start, 
therefore the system became unusable. What could be possible reason for 
that?
