From: rogerq@ti.com (Roger Quadros)
Date: Wed, 29 Jun 2016 09:10:57 +0300
Subject: [PATCH] extcon: Add support for qcom SPMI PMIC USB id detection
 hardware
In-Reply-To: <146715129359.31418.3271966598208551482@sboyd-linaro>
References: <20160626055647.18898-1-stephen.boyd@linaro.org>
 <5770D847.7060901@ti.com>
 <146705583219.30684.18055040268826215722@sboyd-linaro>
 <57721AEA.6010509@ti.com>
 <146710362771.3879.13924434427129313640@sboyd-linaro>
 <57723FD5.8050305@ti.com>
 <146715129359.31418.3271966598208551482@sboyd-linaro>
Message-ID: <57736671.6090800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/06/16 01:01, Stephen Boyd wrote:
> Quoting Roger Quadros (2016-06-28 02:13:57)
>> On 28/06/16 11:47, Stephen Boyd wrote:
>>>
>>> Sorry I must have confused you. There are two modules in the PMIC that
>>> are doing detection here. The charger module is detecting the VBUS event
>>> and this misc module is detecting the ID pin. I'm not sure why they're
>>> two different blocks, but it is what it is in the hardware.
>>>
>> OK. Can the MISC block do anything else other than USB ID?
> 
> Yes.
> 
>> Does the USB ID interrupt come on a different line than the charger interrupt?
> 
> Yes.
> 

OK. Is it better to have this driver somewhere in drivers/mfd or drivers/misc if the
other function doesn't need/use extcon?

>>
>> It would be more like MISC block interrupt than USB ID interrupt right?
> 
> There are two interrupts going to two different hw blocks inside the
> PMIC.
> 

cheers,
-roger
