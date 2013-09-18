From: nm@ti.com (Nishanth Menon)
Date: Wed, 18 Sep 2013 08:44:21 -0500
Subject: [PATCH] ARM: OMAP5/DRA7: realtime_counter: Configure CNTFRQ
 register
In-Reply-To: <5239AB2C.1090201@ti.com>
References: <1379503416-26318-1-git-send-email-r.sricharan@ti.com>
 <5239AB2C.1090201@ti.com>
Message-ID: <5239AE35.8030406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2013 08:31 AM, Santosh Shilimkar wrote:
> On Wednesday 18 September 2013 07:23 AM, Sricharan R wrote:
[...]
						4, 0, 0, 0, 0, 0);
>>  
>>  	/*
>> +	 * Configure the CNTFRQ register for the secondary cpu's which
>> +	 * indicates the frequency of the cpu local timers.
>> +	 */
>> +	if (soc_is_omap54xx() || soc_is_dra7xx())
> CNTFREQ programming was not supported on OMAP5 ES1.0 and that was one
> of the reason this parameter came into picture. So you need to skip
> the ES1.0 here. 
> 
Even though ES1.0 is present in id.c, we have 0 support for ES1.0.

ES1.0 was more or less a test chip, no production devices were
manufactured with it, no public boards (including uevms) are available
to purchase with ES1.0. Further, inside TI, all ES1.0 samples and
boards have been scrapped and replaced with ES2.0 platforms.

In short, no users and dead code in kernel tree. I dont see why we
cant just cleanup OMAP5 ES1.0 entirely from kernel tree?

-- 
Regards,
Nishanth Menon
