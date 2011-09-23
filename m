From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Fri, 23 Sep 2011 09:54:28 +0530
Subject: [PATCH v7 00/26] gpio/omap: driver cleanup and fixes
In-Reply-To: <87fwjotity.fsf@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<CAC83ZvKa7R_rUe-Fa15m0_5P-GE4WC2thazQ+iqF-HAqn8cE1w@mail.gmail.com>
	<87fwjotity.fsf@ti.com>
Message-ID: <CAC83ZvJ90sq=bWyL2rVJWsHhRTDGCHOxX=mrUFGD4gRCa5FdoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]
>>> This series is continuation of cleanup of OMAP GPIO driver and fixes.
>>> The cleanup include getting rid of cpu_is_* checks wherever possible,
>>> use of gpio_bank list instead of static array, use of unique platform
>>> specific value associated data member to OMAP platforms to avoid
>>> cpu_is_* checks. The series also include PM runtime support.*
>>>
>>> Baseline: git://gitorious.org/khilman/linux-omap-pm.git
>>> Branch: for_3.2/gpio-cleanup
>>> Commit: 8323374
>> Thanks Tony for ack'ing the patches.
>> Kevin,
>> Since Tony's has acked the patches, can you please pull them?
>
> Before merging, I still need to review and test this version, and I
> *might* still get to it this week.
That's fine. Thanks.
>
> Based on the dbclk aliases you added, I assume this has now been tested
> on platforms using some GPIOs with debounce enabled?
I have replicated gpio_debounce() code within *_gpio_mod_init() whereby
_set_gpio_debounce() is called to enable debounce.
After this, confirmed system going to off-mode through the CPU IDLE path.
--
Tarun
>
> Kevin
>
