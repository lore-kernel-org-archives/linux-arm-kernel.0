From: vigneshr@ti.com (Vignesh R)
Date: Mon, 17 Nov 2014 17:48:43 +0530
Subject: [PATCH 0/4] Touchscreen performance related fixes
In-Reply-To: <5458C87F.80409@linutronix.de>
References: <1414408111-2631-1-git-send-email-vigneshr@ti.com>
 <544E821D.5040004@linutronix.de>
 <912A29987EAE174BA6CF187D7CDFA9CE26F46B2B@DLEE08.ent.ti.com>
 <54577258.9080508@linutronix.de> <5458BC0B.1040803@ti.com>
 <5458C87F.80409@linutronix.de>
Message-ID: <5469E7A3.2000303@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 04 November 2014 06:07 PM, Sebastian Andrzej Siewior wrote:
> On 11/04/2014 12:44 PM, Vignesh R wrote:
> 
>> I ran following commands
>> $ evtest /dev/input/touchscreen0 &
>> (with heavy item on touchscreen)
>>  and
>> $ cat /sys/bus/iio/devices/iio\:device0/scan_elements/in_voltage4_en
>> (in a busy loop)
>> I tried above experiment on my board but I didn't hit any problem even
>> after running for close to 30 minutes. I was unable to reproduce failure
> 
> Just to make sure: You had the touchscreen and iio command running in
> parallel and you saw evtest output while there was iio operation?
> 
>> The problem may be in configuring correct charge-delay value. Please run:
>> $ ts_test > /dev/null
>> and let me know if pen events are being detected properly.
> 
> Well I get the touch events but not while busy loop on iio interface is
> running (I get maybe one event every 5 seconds or so).
> After all, it is the same HW you have.

Were you able to test the latest version (v4) of this patch series?
Please let me know if the performance is satisfactory.

Regards
Vignesh

> 
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
