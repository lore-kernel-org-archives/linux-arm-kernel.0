From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 23 Apr 2014 11:57:25 +0200
Subject: [linux-sunxi] Re: [PATCH v8 07/17] ARM: dts: sun5i: Add mmc
 controller nodes
In-Reply-To: <20140423094840.GL24905@lukather>
References: <1398164497-14212-1-git-send-email-hdegoede@redhat.com>
 <1398164497-14212-8-git-send-email-hdegoede@redhat.com>
 <20140423094840.GL24905@lukather>
Message-ID: <53578E85.9000906@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/23/2014 11:48 AM, Maxime Ripard wrote:
> On Tue, Apr 22, 2014 at 01:01:27PM +0200, Hans de Goede wrote:
>> From: David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
>>
>> Add nodes for the 3 mmc controllers found on A10s SoCs and for the 2 mmc
>> controllers found on A13 SoCs.
>>
>> Signed-off-by: David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  arch/arm/boot/dts/sun5i-a10s.dtsi | 27 +++++++++++++++++++++++++++
>>  arch/arm/boot/dts/sun5i-a13.dtsi  | 18 ++++++++++++++++++
>>  2 files changed, 45 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
>> index 79989ed..12113f9 100644
>> --- a/arch/arm/boot/dts/sun5i-a10s.dtsi
>> +++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
>> @@ -338,6 +338,33 @@
>>  			#size-cells = <0>;
>>  		};
>>  
>> +		mmc0: mmc at 01c0f000 {
>> +			compatible = "allwinner,sun5i-a13-mmc";
>> +			reg = <0x01c0f000 0x1000>;
>> +			clocks = <&ahb_gates 8>, <&mmc0_clk>;
>> +			clock-names = "ahb", "mod";
>> +			interrupts = <32>;
>> +			status = "disabled";
>> +		};
>> +
>> +		mmc1: mmc at 01c10000 {
>> +			compatible = "allwinner,sun5i-a13-mmc";
>> +			reg = <0x01c10000 0x1000>;
>> +			clocks = <&ahb_gates 9>, <&mmc1_clk>;
>> +			clock-names = "ahb", "mod";
>> +			interrupts = <33>;
>> +			status = "disabled";
>> +		};
>> +
>> +		mmc2: mmc at 01c11000 {
>> +			compatible = "allwinner,sun5i-a13-mmc";
>> +			reg = <0x01c11000 0x1000>;
>> +			clocks = <&ahb_gates 10>, <&mmc2_clk>;
>> +			clock-names = "ahb", "mod";
>> +			interrupts = <34>;
>> +			status = "disabled";
>> +		};
>> +
>>  		usbphy: phy at 01c13400 {
>>  			#phy-cells = <1>;
>>  			compatible = "allwinner,sun5i-a13-usb-phy";
>> diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
>> index f01c315..a0e55e8 100644
>> --- a/arch/arm/boot/dts/sun5i-a13.dtsi
>> +++ b/arch/arm/boot/dts/sun5i-a13.dtsi
>> @@ -320,6 +320,24 @@
>>  			#size-cells = <0>;
>>  		};
>>  
>> +		mmc0: mmc at 01c0f000 {
>> +			compatible = "allwinner,sun5i-a13-mmc";
>> +			reg = <0x01c0f000 0x1000>;
>> +			clocks = <&ahb_gates 8>, <&mmc0_clk>;
>> +			clock-names = "ahb", "mod";
>> +			interrupts = <32>;
>> +			status = "disabled";
>> +		};
>> +
>> +		mmc2: mmc at 01c11000 {
>> +			compatible = "allwinner,sun5i-a13-mmc";
>> +			reg = <0x01c11000 0x1000>;
>> +			clocks = <&ahb_gates 10>, <&mmc2_clk>;
>> +			clock-names = "ahb", "mod";
>> +			interrupts = <34>;
>> +			status = "disabled";
>> +		};
>> +
> 
> The A13 user manual reports that there is 3 of them in the A13, just
> like on the A10s. Have you forgotten one?

mmc1 is likely there, but it is not usable as it is not routed to the outside,
so I've left it out deliberately.

Regards,

Hans
