From: george.cherian@ti.com (George Cherian)
Date: Tue, 9 Jul 2013 16:51:35 +0530
Subject: [PATCH v2] arm: dts: AM43x: Add usb_otg_hs node
In-Reply-To: <20130709102022.GH5552@arwen.pp.htv.fi>
References: <1373361446-30050-1-git-send-email-george.cherian@ti.com>
 <20130709102022.GH5552@arwen.pp.htv.fi>
Message-ID: <51DBF23F.20103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/9/2013 3:50 PM, Felipe Balbi wrote:
> On Tue, Jul 09, 2013 at 02:47:26PM +0530, George Cherian wrote:
>> Adds device node for HS USB Host module for AM437x
>>
>> changes from v1
>>
>> renamed synopsis to snps
>> removed flag tx-fifo-resize
> the patch revision changes don't need to go to the commit log,
> they should be placed after the tearline (---) and before the diffstat.
>
>> Signed-off-by: George Cherian <george.cherian@ti.com>
>> ---
>>   arch/arm/boot/dts/am4372.dtsi | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
>> index ddc1df7..c9e0da8 100644
>> --- a/arch/arm/boot/dts/am4372.dtsi
>> +++ b/arch/arm/boot/dts/am4372.dtsi
>> @@ -64,5 +64,23 @@
>>   			compatible = "ti,am4372-counter32k","ti,omap-counter32k";
>>   			reg = <0x44e86000 0x40>;
>>   		};
>> +
>> +		usb_otg_hs1: am4372_dwc3 at 48380000 {
> dtsi should always have status = "disabled"; no ?
>
>> +			compatible = "ti,am437x-dwc3";
>> +			reg = <0x48380000 0x1ff>;
> weird size, shouldn't this be 0x200 ?
okay
>> +			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			utmi-mode = <1>;
>> +			ranges;
>> +
>> +			dwc3 at 48390000 {
> dtsi should always have status = "disabled"; no ?
okay
>
>> +				compatible = "snps,dwc3";
>> +				reg = <0x48390000 0xcfff>;
> weird size, shouldn't this be 0xd000 then the size would be exactly
> 52KiB

okay
>> +				interrupts = <GIC_SPI  168 IRQ_TYPE_LEVEL_HIGH>;
>> +			};
>> +
>> +		};
>> +		
> there two trailing tabs on this line.
>
> Another thing: am437x has 4 instances of this IP, why are you adding
> only one ?

AM437x has got only 2 instances. I have verified only one on HAPS so 
adding only one.

> And why aren't you pasing the PHY nodes here ? The device
> won't work without its PHYs.

Yes true, again in HAPS I  didnt have any PHY configuration to be done.
>


-- 
-George
