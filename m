From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 09 Jul 2013 19:01:23 +0400
Subject: [PATCH v2] arm: dts: AM43x: Add usb_otg_hs node
In-Reply-To: <51DC1937.9080302@cogentembedded.com>
References: <1373361446-30050-1-git-send-email-george.cherian@ti.com>
 <51DC1937.9080302@cogentembedded.com>
Message-ID: <51DC25C3.6000901@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/09/2013 06:07 PM, Sergei Shtylyov wrote:

>> Adds device node for HS USB Host module for AM437x

>> changes from v1

>> renamed synopsis to snps
>> removed flag tx-fifo-resize

>> Signed-off-by: George Cherian <george.cherian@ti.com>
>> ---
>>   arch/arm/boot/dts/am4372.dtsi | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)

>> diff --git a/arch/arm/boot/dts/am4372.dtsi
>> b/arch/arm/boot/dts/am4372.dtsi
>> index ddc1df7..c9e0da8 100644
>> --- a/arch/arm/boot/dts/am4372.dtsi
>> +++ b/arch/arm/boot/dts/am4372.dtsi
>> @@ -64,5 +64,23 @@
>>               compatible = "ti,am4372-counter32k","ti,omap-counter32k";
>>               reg = <0x44e86000 0x40>;
>>           };
>> +
>> +        usb_otg_hs1: am4372_dwc3 at 48380000 {
>
>     See http://www.devicetree.org/Device_Tree_Usage, "Node Names" section.
>
>> +            compatible = "ti,am437x-dwc3";
>> +            reg = <0x48380000 0x1ff>;

    And I bet this should be 0x200, not 0x1ff. This is length, not upper 
limit.

>> +            interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            utmi-mode = <1>;
>> +            ranges;
>> +
>> +            dwc3 at 48390000 {

>     The same comment.

>> +                compatible = "snps,dwc3";
>> +                reg = <0x48390000 0xcfff>;

    The same, this should be 0xd000, not 0xcfff.

>> +                interrupts = <GIC_SPI  168 IRQ_TYPE_LEVEL_HIGH>;
>> +            };
>> +
>> +        };
>> +

WBR, Sergei
