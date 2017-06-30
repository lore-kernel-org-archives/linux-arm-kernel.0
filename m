From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Fri, 30 Jun 2017 13:12:33 +0200
Subject: [PATCH 4/6] dt-bindings: serial: Document RDA Micro UART
In-Reply-To: <20170629201051.cfr37kh2gozompqo@rob-hp-laptop>
References: <20170627005520.23731-1-afaerber@suse.de>
 <20170627005520.23731-5-afaerber@suse.de>
 <20170629201051.cfr37kh2gozompqo@rob-hp-laptop>
Message-ID: <e8b8eb0c-0362-0cfb-4d18-3e1ab2b77412@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 29.06.2017 um 22:10 schrieb Rob Herring:
> On Tue, Jun 27, 2017 at 02:55:18AM +0200, Andreas F?rber wrote:
>> Add an initial binding for the RDA8810PL UART.
>>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  Documentation/devicetree/bindings/serial/rda-uart.txt | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/serial/rda-uart.txt
>>
>> diff --git a/Documentation/devicetree/bindings/serial/rda-uart.txt b/Documentation/devicetree/bindings/serial/rda-uart.txt
>> new file mode 100644
>> index 000000000000..6840a8aee035
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/serial/rda-uart.txt
>> @@ -0,0 +1,13 @@
>> +RDA Micro UART
>> +
>> +Required properties:
>> +- compatible :  "rda,8810pl-uart" for RDA8810PL
>> +- reg        :  Offset and length of the register set for the device.
> 
> No clocks or interrupts?

Not yet. I've only pieced together an earlycon driver so far, no full
serial driver. The .dtsi doesn't even have an interrupt-controller node
yet - wasn't clear to me whether this SoC even has a GIC and, if so,
where, from the downstream pre-DT code.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
