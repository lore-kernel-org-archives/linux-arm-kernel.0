From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 18 Jan 2017 14:35:23 +0530
Subject: [PATCH v2 01/14] devicetree: bindings: add bindings for ahci-da850
In-Reply-To: <7e3c8946-2a19-3e11-c071-b3737554005c@lechnology.com>
References: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
 <1484655976-25382-2-git-send-email-bgolaszewski@baylibre.com>
 <7e3c8946-2a19-3e11-c071-b3737554005c@lechnology.com>
Message-ID: <792384a9-a7d3-56f5-5178-f3b0f8e7114a@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 January 2017 12:05 AM, David Lechner wrote:
> On 01/17/2017 06:26 AM, Bartosz Golaszewski wrote:
>> Add DT bindings for the TI DA850 AHCI SATA controller.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  Documentation/devicetree/bindings/ata/ahci-da850.txt | 18
>> ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt
>>
>> diff --git a/Documentation/devicetree/bindings/ata/ahci-da850.txt
>> b/Documentation/devicetree/bindings/ata/ahci-da850.txt
>> new file mode 100644
>> index 0000000..e7111b4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/ata/ahci-da850.txt
>> @@ -0,0 +1,18 @@
>> +Device tree binding for the TI DA850 AHCI SATA Controller
>> +---------------------------------------------------------
>> +
>> +Required properties:
>> +  - compatible: must be "ti,da850-ahci"
>> +  - reg: physical base addresses and sizes of the controller's
>> register areas
>> +  - interrupts: interrupt specifier (refer to the interrupt binding)
>> +
>> +Optional properties:
>> +  - clocks: clock specifier (refer to the common clock binding)
> 
> Won't you also need a clock-names property since there are two clocks?
> 
>> +
>> +Example:
>> +
>> +    sata: ahci at 218000 {
>> +        compatible = "ti,da850-ahci";
>> +        reg = <0x218000 0x2000>, <0x22c018 0x4>;
>> +        interrupts = <67>;
>> +    };
>>
> 
> It would be nice to have clocks and clock-names in the example as well.

Well, we don't use the common clock binding today. Is it really
necessary to add them now. Thats basically going to remain completely
untested.

I would drop the mention of clocks specification as an optional property
too.

Thanks,
Sekhar
