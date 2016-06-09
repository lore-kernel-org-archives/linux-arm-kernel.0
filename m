From: marex@denx.de (Marek Vasut)
Date: Thu, 09 Jun 2016 04:18:11 +0200
Subject: [PATCH V2 4/4] ARM: mxs: dts: Add SanDisk Sansa Fuze+ support
In-Reply-To: <20160609021341.GA15413@tiger>
References: <1462740621-7557-1-git-send-email-marex@denx.de>
 <1462740621-7557-4-git-send-email-marex@denx.de>
 <20160609012112.GA15053@tiger> <5758C6A8.2060903@denx.de>
 <20160609021341.GA15413@tiger>
Message-ID: <5758D1E3.4080203@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/2016 04:13 AM, Shawn Guo wrote:
> On Thu, Jun 09, 2016 at 03:30:16AM +0200, Marek Vasut wrote:
>> On 06/09/2016 03:21 AM, Shawn Guo wrote:
>>> On Sun, May 08, 2016 at 10:50:21PM +0200, Marek Vasut wrote:
>>>> +	regulators {
>>>> +		compatible = "simple-bus";
>>>> +
>>>> +		reg_vddio_sd0: vddio-sd0 {
>>>
>>> Put fixed regulator nodes directly under root with suggested naming
>>> scheme.
>>>
>>>> +			compatible = "regulator-fixed";
>>>> +			regulator-name = "vddio-sd0";
>>>> +			regulator-min-microvolt = <3300000>;
>>>> +			regulator-max-microvolt = <3300000>;
>>>> +			gpio = <&gpio0 8 0>;
>>>> +		};
>>>> +
>>>> +		reg_vddio_sd1: vddio-sd1 {
>>>> +			compatible = "regulator-fixed";
>>>> +			regulator-name = "vddio-sd1";
>>>> +			regulator-min-microvolt = <3300000>;
>>>> +			regulator-max-microvolt = <3300000>;
>>>> +			gpio = <&gpio1 29 0>;
>>>> +		};
>>>> +
>>>> +		reg_vdd_touchpad: vdd-touchpad0 {
>>>> +			compatible = "regulator-fixed";
>>>> +			regulator-name = "vdd-touchpad0";
>>>> +			regulator-min-microvolt = <3300000>;
>>>> +			regulator-max-microvolt = <3300000>;
>>>> +			gpio = <&gpio0 26 0>;
>>>> +			regulator-always-on;
>>>> +			enable-active-low;
>>>> +		};
>>>> +
>>>> +		reg_vdd_tuner: vdd-tuner0 {
>>>> +			compatible = "regulator-fixed";
>>>> +			regulator-name = "vdd-tuner0";
>>>> +			regulator-min-microvolt = <3300000>;
>>>> +			regulator-max-microvolt = <3300000>;
>>>> +			gpio = <&gpio0 29 0>;
>>>> +			regulator-always-on;
>>>> +			enable-active-low;
>>>> +		};
>>>> +	};
>>>> +
>>>> +	backlight {
>>>> +		compatible = "pwm-backlight";
>>>> +		pwms = <&pwm 2 5000000>;
>>>> +		brightness-levels = <0 4 8 16 32 64 128 255>;
>>>> +		default-brightness-level = <6>;
>>>> +	};
>>>> +
>>>> +	i2c at 0 {
>>>
>>> The @unit-address should be used for nodes with 'reg' property.
>>
>> Can you please do such minor fixes when applying or do you expect a resend ?
> 
> Such minor fixes are just too many to be fixed by myself.  Please
> resend.

I see. Would you be able to review them in less than one month please ?
It is extremely demotivating to wait over a month only to get a review
with a few nitpicks and request to resend.

-- 
Best regards,
Marek Vasut
