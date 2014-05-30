From: yoshihiro.shimoda.uh@renesas.com (Yoshihiro Shimoda)
Date: Fri, 30 May 2014 21:14:05 +0900
Subject: [PATCH 2/2] arm: shmobile: r8a7790: add USB3.0 node to
 r8a7790.dtsi
In-Reply-To: <53875B7E.5010104@cogentembedded.com>
References: <53871338.8050606@renesas.com>
 <53875B7E.5010104@cogentembedded.com>
Message-ID: <5388760D.3020101@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

(2014/05/30 1:08), Sergei Shtylyov wrote:
> Hello.
> 
> On 05/29/2014 03:00 PM, Yoshihiro Shimoda wrote:
> 
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> ---
>>   arch/arm/boot/dts/r8a7790.dtsi |   10 ++++++++++
>>   1 file changed, 10 insertions(+)
> 
>> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
>> index e06c486..e6b04f2 100644
>> --- a/arch/arm/boot/dts/r8a7790.dtsi
>> +++ b/arch/arm/boot/dts/r8a7790.dtsi
>> @@ -902,4 +902,14 @@
>>   		#size-cells = <0>;
>>   		status = "disabled";
>>   	};
>> +
>> +	xhci: xhci at ee000000 {
> 
>     The node name should be "usb at ee000000", according to section 2.2.2 of the 
> ePAPR standard [1]:

Thank you for the point! I will fix this and r8a7791's one.

>> +		compatible = "renesas,xhci-r8a7790";
>> +		reg = <0 0xee000000 0 0xc00>;
>> +		interrupts = <0 101 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&mstp3_clks R8A7790_CLK_SSUSB>;
>> +		phys = <&usbphy 1 1>;
> 
>     This part is dependent on the generic PHY support in the USB HCD in order 
> to work.

This means that I should wait to add this parameter until the generic USB PHY Gen2
driver is supported in upstream?

Best regards,
Yoshihiro Shimoda

>> +		phy-names = "usb";
>> +		status = "disabled";
>> +	};
>>   };
> 
> [1] http://www.power.org/resources/downloads/Power_ePAPR_APPROVED_v1.0.pdf
> 
> WBR, Sergei
> 

-- 
Yoshihiro Shimoda
