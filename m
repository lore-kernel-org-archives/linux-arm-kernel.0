From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Mon, 24 Nov 2014 13:35:06 +0100
Subject: [PATCH v4 0/6] Touchscreen performance related fixes
In-Reply-To: <547321A2.6010207@ti.com>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com>
 <20141124115116.GA14997@linutronix.de> <547321A2.6010207@ti.com>
Message-ID: <547325FA.6020004@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24/2014 01:16 PM, Vignesh R wrote:

> I have tried running both IIO and TSC at the same time. But I have never
> seen WARN_ON() even after running for close to 30 min. Can you send me
> the exact script, so that it will be easy to reproduce?

Sure thing.
- one shell
	evtest /dev/input/event2
- second shell
	./iio-test.sh
  with:

|#!/bin/sh
|
|while [ 1 = 1 ]
|do
|        cat /sys/bus/iio/devices/iio\:device0/in_voltage4_raw
|done


the kernel config: https://breakpoint.cc/am335x-config

> 
> Regards
> Vignesh

Sebastian
