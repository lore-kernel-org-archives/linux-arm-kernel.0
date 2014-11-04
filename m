From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Tue, 04 Nov 2014 13:37:19 +0100
Subject: [PATCH 0/4] Touchscreen performance related fixes
In-Reply-To: <5458BC0B.1040803@ti.com>
References: <1414408111-2631-1-git-send-email-vigneshr@ti.com>
 <544E821D.5040004@linutronix.de>
 <912A29987EAE174BA6CF187D7CDFA9CE26F46B2B@DLEE08.ent.ti.com>
 <54577258.9080508@linutronix.de> <5458BC0B.1040803@ti.com>
Message-ID: <5458C87F.80409@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/2014 12:44 PM, Vignesh R wrote:

> I ran following commands
> $ evtest /dev/input/touchscreen0 &
> (with heavy item on touchscreen)
>  and
> $ cat /sys/bus/iio/devices/iio\:device0/scan_elements/in_voltage4_en
> (in a busy loop)
> I tried above experiment on my board but I didn't hit any problem even
> after running for close to 30 minutes. I was unable to reproduce failure

Just to make sure: You had the touchscreen and iio command running in
parallel and you saw evtest output while there was iio operation?

> The problem may be in configuring correct charge-delay value. Please run:
> $ ts_test > /dev/null
> and let me know if pen events are being detected properly.

Well I get the touch events but not while busy loop on iio interface is
running (I get maybe one event every 5 seconds or so).
After all, it is the same HW you have.

Sebastian
