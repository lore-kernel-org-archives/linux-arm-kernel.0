From: rogerq@ti.com (Roger Quadros)
Date: Tue, 28 Jun 2016 12:13:57 +0300
Subject: [PATCH] extcon: Add support for qcom SPMI PMIC USB id detection
 hardware
In-Reply-To: <146710362771.3879.13924434427129313640@sboyd-linaro>
References: <20160626055647.18898-1-stephen.boyd@linaro.org>
 <5770D847.7060901@ti.com>
 <146705583219.30684.18055040268826215722@sboyd-linaro>
 <57721AEA.6010509@ti.com>
 <146710362771.3879.13924434427129313640@sboyd-linaro>
Message-ID: <57723FD5.8050305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/06/16 11:47, Stephen Boyd wrote:
> Quoting Roger Quadros (2016-06-27 23:36:26)
>> On 27/06/16 22:30, Stephen Boyd wrote:
>>>
>>> The VBUS notification is done through another piece of hardware. In this
>>> case it's done by the charger module. I've sent a patch for that[1].
>>
>> Isn't it better if ID event is handled as well in that PMIC driver instead of
>> creating a separate one here?
>>
>> Why do you need ID to be handled outside of the PMIC driver?
>> You mentioned earlier that some Qualcomm PMICs have ID detection.
>
> Sorry I must have confused you. There are two modules in the PMIC that
> are doing detection here. The charger module is detecting the VBUS event
> and this misc module is detecting the ID pin. I'm not sure why they're
> two different blocks, but it is what it is in the hardware.
> 
OK. Can the MISC block do anything else other than USB ID?
Does the USB ID interrupt come on a different line than the charger interrupt?

It would be more like MISC block interrupt than USB ID interrupt right?

cheers,
-roger
