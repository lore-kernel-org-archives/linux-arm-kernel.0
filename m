From: rogerq@ti.com (Roger Quadros)
Date: Tue, 5 Feb 2013 10:57:58 +0200
Subject: [PATCH 10/13] ARM: dts: OMAP4: Add HS USB Host IP nodes
In-Reply-To: <20130205074141.GB32118@arwen.pp.htv.fi>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com>
 <1359993540-20780-11-git-send-email-rogerq@ti.com>
 <20130205074141.GB32118@arwen.pp.htv.fi>
Message-ID: <5110C996.6020208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2013 09:41 AM, Felipe Balbi wrote:
> On Mon, Feb 04, 2013 at 05:58:57PM +0200, Roger Quadros wrote:
>> Adds device nodes for HS USB Host module, TLL module,
>> OHCI and EHCI controllers.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  arch/arm/boot/dts/omap4.dtsi |   30 ++++++++++++++++++++++++++++++
>>  1 files changed, 30 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
>> index 739bb79..3429280 100644
>> --- a/arch/arm/boot/dts/omap4.dtsi
>> +++ b/arch/arm/boot/dts/omap4.dtsi
>> @@ -529,5 +529,35 @@
>>  			ti,hwmods = "timer11";
>>  			ti,timer-pwm;
>>  		};
>> +
>> +		usbhstll: usbhstll at 0x4a062000 {
>> +			compatible = "ti,usbhs-tll";
>> +			reg = <0x4a062000 0x1000>;
>> +			interrupts = <0 78 0x4>;
>> +			ti,hwmods = "usb_tll_hs";
>> +		};
>> +
>> +		usbhshost: usbhshost at 0x4a064000 {
>> +			compatible = "ti,usbhs-host";
>> +			reg = <0x4a064000 0x800>;
>> +			ti,hwmods = "usb_host_hs";
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +
>> +			usbhsohci: ohci at 0x4a064800 {
> 
> usbhsohci is a bit misleading :-)
> 
> How about we stick to ohci and ehci for these nodes ? :-)
> 
Was just thinking of a unique label that will point to the OHCI/EHCI
controller in the HS USB subsystem. We need the label to provide
PHY information in the board DT.

If we are sure we won't have another OHCI/EHCI controller then I can
just use ehci/ohci.

cheers,
-roger
