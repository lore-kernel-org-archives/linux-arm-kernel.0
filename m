From: rogerq@ti.com (Roger Quadros)
Date: Wed, 14 Aug 2013 11:16:48 +0300
Subject: [PATCH 3/4] ARM: dts: omap4-panda: Provide USB PHY clock
In-Reply-To: <520B3BC5.4080409@ti.com>
References: <1374676356-31286-1-git-send-email-rogerq@ti.com>
 <1374676356-31286-4-git-send-email-rogerq@ti.com> <520B3BC5.4080409@ti.com>
Message-ID: <520B3CF0.5060505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/2013 11:11 AM, Roger Quadros wrote:
> +Benoit
> 
> On 07/24/2013 05:32 PM, Roger Quadros wrote:
>> The USB PHY gets its clock from AUXCLK3. Provide this
>> information.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  arch/arm/boot/dts/omap4-panda-common.dtsi |    8 ++------
>>  1 files changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
>> index faa95b5..dd793ca 100644
>> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
>> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
>> @@ -99,12 +99,8 @@
>>  		compatible = "usb-nop-xceiv";
>>  		reset-supply = <&hsusb1_reset>;
>>  		vcc-supply = <&hsusb1_power>;
>> -	/**
>> -	 * FIXME:
>> -	 * put the right clock phandle here when available
>> -	 *	clocks = <&auxclk3>;
>> -	 *	clock-names = "main_clk";
>> -	 */
>> +		clocks = <&auxclk3_ck>;
>> +		clock-names = "main_clk";
>>  		clock-frequency = <19200000>;
>>  	};
>>  };
>>
> 
