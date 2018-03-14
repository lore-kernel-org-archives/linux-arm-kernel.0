From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 14 Mar 2018 16:56:51 +0100
Subject: [PATCH 2/2] usb: host: xhci-plat: Fix clock resource by adding a
 register clock
In-Reply-To: <0643f36a-cee7-8e4a-77c3-c60672ca385f@intel.com> (Mathias Nyman's
 message of "Wed, 28 Feb 2018 18:05:20 +0200")
References: <20180214161620.4401-1-gregory.clement@bootlin.com>
 <20180214161620.4401-3-gregory.clement@bootlin.com>
 <0643f36a-cee7-8e4a-77c3-c60672ca385f@intel.com>
Message-ID: <877eqe1who.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

(resent because of malformed cc list)
 
 On mer., f?vr. 28 2018, Mathias Nyman <mathias.nyman@intel.com> wrote:

> On 14.02.2018 18:16, Gregory CLEMENT wrote:
>> On Armada 7K/8K we need to explicitly enable the register clock. This
>> clock is optional because not all the SoCs using this IP need it but at
>> least for Armada 7K/8K it is actually mandatory.
>>
>> The change was done at xhci-plat level and not at a xhci-mvebu.c because,
>> it is expected that other SoC would have this kind of constraint.
>>
>> The binding documentation is updating accordingly.
>>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> ---
>>   Documentation/devicetree/bindings/usb/usb-xhci.txt |  5 +++-
>>   drivers/usb/host/xhci-plat.c                       | 33 ++++++++++++++++++----
>>   drivers/usb/host/xhci.h                            |  3 +-
>>   3 files changed, 33 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
>> index e2ea59bbca93..e4b14511f4f8 100644
>> --- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
>> +++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
>> @@ -27,7 +27,10 @@ Required properties:
>>     - interrupts: one XHCI interrupt should be described here.
>>     Optional properties:
>> -  - clocks: reference to a clock
>> +  - clocks: reference to the clocks
>> +  - clock-names: mandatory if there is a second clock, in this case
>> +    the name must be "core" for the first clock and "reg" for the
>> +    second one
>>     - usb2-lpm-disable: indicate if we don't want to enable USB2 HW LPM
>>     - usb3-lpm-capable: determines if platform is USB3 LPM capable
>>     - quirk-broken-port-ped: set if the controller has broken port disable mechanism
>
> Would be good to get a Ack or review by Rob Herring for the above

Would you mind to have a look on this binding update ?

Initially I didn't copy you trying to not overflow you because this
change is only about adding a new clock, which is pretty common. But I
think Mathias would be more confident with a Ack or review by you.

Thanks,

Gregory

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
