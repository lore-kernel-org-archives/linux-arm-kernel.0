From: cwchoi00@gmail.com (Chanwoo Choi)
Date: Sat, 21 Nov 2015 01:55:22 +0900
Subject: [PATCH 2/2] arm: boot: beaglex15: pass correct interrupt
In-Reply-To: <564F4D90.4050305@gmail.com>
References: <1447350781-20649-1-git-send-email-balbi@ti.com>
 <1447350781-20649-3-git-send-email-balbi@ti.com>
 <564EB215.5080209@samsung.com> <564F4D90.4050305@gmail.com>
Message-ID: <CAGTfZH3o_G91qDS6_9tYJHDDAbOWj90rBfCKvi0f-uL0L2PcTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Nov 21, 2015 at 1:42 AM, Chanwoo Choi <cwchoi00@gmail.com> wrote:
> Hi,
>
> On 2015. 11. 20. ?? 2:39, Chanwoo Choi wrote:
>> Hi,
>>
>> On 2015? 11? 13? 02:53, Felipe Balbi wrote:
>>> According to latest schematics [1], GPIO_1/VBUSDET
>>> on TPS659038 is tied to AM57x GPIO4_21. We can use
>>> that as a VBUS interrupt, instead of relying on
>>> PMIC's VBUS interrupts which don't seem to be firing
>>> on x15 at all.
>>>
>>> A follow up patch will add support for using this
>>> GPIO-based interrupt mechanism for notifying about
>>> VBUS.
>>>
>>> [1] https://github.com/beagleboard/beagleboard-x15/blob/master/BeagleBoard-X15_RevA2.pdf
>>>
>>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>>> ---
>>>  arch/arm/boot/dts/am57xx-beagle-x15.dts | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
>>> index 6f3a1a7ec5f9..5e47162f7883 100644
>>> --- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
>>> +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
>>> @@ -560,6 +560,7 @@
>>>              extcon_usb2: tps659038_usb {
>>>                      compatible = "ti,palmas-usb-vid";
>>>                      ti,enable-vbus-detection;
>>> +                    interrupts-extended = <&gpio4 21 IRQ_TYPE_EDGE_RISING>;
>
>                         vbus-gpio = <&gpio4 21>;

I'm sorry. I'm sending the missing email without writing completion.

I agree the Felipe's opinion. Just I think that we can use the
following property
instead of 'interrupt-extended'. Because I think 'vbus-gpio' is more
readability than before. The following property mean the attribute of
GPIO pin as VBUS.
- vbus-gpio = <&gpio4 21>;

Thanks,
Chanwoo Choi

>
>>>              };
>>>
>>>      };
>>>
>>
>> I check the schematic file. The GPIO4_21 pin is connected as following:
>> - GPIO_1/VBUSDET -> PMIC_VBUS_DET -> VBUS_DET -> AM5728 GPIO4_21 pin
>>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>
>> Thanks,
>> Chanwoo Choi
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
