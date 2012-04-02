From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 02 Apr 2012 12:19:57 +0200
Subject: [PATCH 03/12] ARM: at91/USB host: specify and handle properly
 vbus_pin_active_low
In-Reply-To: <4F777C6F.2070603@mvista.com>
References: <cover.1333026637.git.nicolas.ferre@atmel.com>
 <ce442f466ded5a4c75a0fc15700dc14fe60b91d8.1333026637.git.nicolas.ferre@atmel.com>
 <4F777C6F.2070603@mvista.com>
Message-ID: <4F797D4D.3060703@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/31/2012 11:51 PM, Sergei Shtylyov :
> Hello.
> 
> On 29-03-2012 17:27, Nicolas Ferre wrote:
> 
>> Due to an error while handling vbus_pin_active_low in ohci-at91 driver,
>> the specification of this property was not good in devices/board files.
> 
>> Signed-off-by: Nicolas Ferre<nicolas.ferre@atmel.com>
>> Acked-by: Jean-Christophe PLAGNIOL-VILLARD<plagnioj@jcrosoft.com>
>> Cc: stable<stable@vger.kernel.org>          [3.2+]
>> ---
>>   arch/arm/mach-at91/at91sam9263_devices.c |    3 ++-
>>   arch/arm/mach-at91/at91sam9g45_devices.c |    6 ++++--
>>   arch/arm/mach-at91/board-sam9263ek.c     |    1 +
>>   arch/arm/mach-at91/board-sam9m10g45ek.c  |    1 +
>>   4 files changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-at91/at91sam9263_devices.c
>> b/arch/arm/mach-at91/at91sam9263_devices.c
>> index 53688c4..5cdca89d 100644
>> --- a/arch/arm/mach-at91/at91sam9263_devices.c
>> +++ b/arch/arm/mach-at91/at91sam9263_devices.c
>> @@ -72,7 +72,8 @@ void __init at91_add_device_usbh(struct
>> at91_usbh_data *data)
>>       /* Enable VBus control for UHP ports */
>>       for (i = 0; i<  data->ports; i++) {
>>           if (gpio_is_valid(data->vbus_pin[i]))
>> -            at91_set_gpio_output(data->vbus_pin[i], 0);
>> +            at91_set_gpio_output(data->vbus_pin[i],
>> +                         data->vbus_pin_active_low[i] ^ 0);
> 
>    Note that XOR with 0 is a nop, left operand doesn't change its value.

Sure I will correct that.

Thanks, best regards,
-- 
Nicolas Ferre
