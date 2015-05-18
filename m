From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 18 May 2015 09:58:40 +0100
Subject: [PATCH v2] ARM: vexpress: Add unified-cache Device Tree property
In-Reply-To: <20150516201301.GT14416@pengutronix.de>
References: <5509437E.6060806@arm.com>
 <1426671298-2012-1-git-send-email-r.schwebel@pengutronix.de>
 <20150429191228.GO15254@pengutronix.de>
 <20150430110853.GN7440@e106497-lin.cambridge.arm.com>
 <20150430133011.GE15254@pengutronix.de> <55426A26.9060704@arm.com>
 <20150516201301.GT14416@pengutronix.de>
Message-ID: <5559A9C0.1020307@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/05/15 21:13, Robert Schwebel wrote:
> Hi Sudeep,
>
> On Thu, Apr 30, 2015 at 06:45:10PM +0100, Sudeep Holla wrote:
>>> I still see these errors with 4.1-rc1:
>>>
>>> [    0.000000] L2C: platform modifies aux control register: 0x02020000 -> 0x02420000
>>> [    0.000000] L2C: DT/platform modifies aux control register: 0x02020000 -> 0x02420000
>>> [    0.268626] platform 10000000.sysreg: Error -2 creating of_node link
>>> [    0.271997] platform basic-mmio-gpio.1.auto: Error -2 creating of_node link
>>> [    0.272266] platform basic-mmio-gpio.2.auto: Error -2 creating of_node link
>>> [    0.272681] platform basic-mmio-gpio.3.auto: Error -2 creating of_node link
>>
>> OK, I was able to debug this, it boils down to initcall ordering.
>> Both of_init where the firmware sysfs is initialized and
>> vexpress_sysreg_init are at same core_initcall level. Needs some
>> thinking and more time to fix this.
>
> Did you find out something in the meantime?
> I just tested 4.1-rc3 and the issues are still confirmed.
>

Ah sorry, forgot to include you or your Reported-by(will
fix that if/when I have to repost a newer version)
I posted the patch but not yet pulled in mainline yet [1]

Regards,
Sudeep

[1] https://lkml.org/lkml/2015/5/14/360
