From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon, 25 Sep 2017 11:24:43 +0200
Subject: [RFC PATCH 6/7] arm64: allwinner: a64: add power supply nodes in
 AXP803 DTSI
In-Reply-To: <D7CAB179-F2AF-434F-82F7-07F146842FCF@aosc.io>
References: <20170920151814.22461-1-icenowy@aosc.io>
 <20170920151814.22461-7-icenowy@aosc.io>
 <7ce5c53e-70ba-456e-ecf7-5132ef2c2c64@free-electrons.com>
 <D7CAB179-F2AF-434F-82F7-07F146842FCF@aosc.io>
Message-ID: <39833379-66a4-4657-3d12-26bc51c88815@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Icenowy,

On 25/09/2017 11:14, Icenowy Zheng wrote:
> 
> 
> ? 2017?9?25? GMT+08:00 ??5:11:57, Quentin Schulz <quentin.schulz@free-electrons.com> ??:
>> Hi Icenowy,
>>
>> On 20/09/2017 17:18, Icenowy Zheng wrote:
>>> AXP803 PMIC features AC/USB/Battery power supplies.
>>>
>>> As we have now the device tree bindings for them, add device tree
>>> nodes for them.
>>>
>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>> ---
>>>  arch/arm64/boot/dts/allwinner/axp803.dtsi | 15 +++++++++++++++
>>>  1 file changed, 15 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/allwinner/axp803.dtsi
>> b/arch/arm64/boot/dts/allwinner/axp803.dtsi
>>> index ff8af52743ff..3a8615231b7c 100644
>>> --- a/arch/arm64/boot/dts/allwinner/axp803.dtsi
>>> +++ b/arch/arm64/boot/dts/allwinner/axp803.dtsi
>>> @@ -49,6 +49,16 @@
>>>  	interrupt-controller;
>>>  	#interrupt-cells = <1>;
>>>  
>>> +	ac_power_supply: ac-power-supply {
>>> +		compatible = "x-powers,axp221-ac-power-supply";
>>> +		status = "disabled";
>>> +	};
>>> +
>>> +	battery_power_supply: battery-power-supply {
>>> +		compatible = "x-powers,axp803-battery-power-supply";
>>> +		status = "disabled";
>>> +	};
>>> +
>>>  	regulators {
>>>  		/* Default work frequency for buck regulators */
>>>  		x-powers,dcdc-freq = <3000>;
>>> @@ -147,4 +157,9 @@
>>>  			regulator-name = "rtc-ldo";
>>>  		};
>>>  	};
>>> +
>>> +	usb_power_supply: usb_power_supply {
>>> +		compatible = "x-powers,axp803-usb-power-supply";
>>> +		status = "disabled";
>>> +	};
>>
>> No. You have added support for the AC and battery power supply drivers
>> in this patchset, not for USB.
> 
> But I added its device tree binding.

Yes and that is wrong. That would mislead users into thinking the usb
power supply is supported (since the dt binding is here) while it's not.

I would add the dt binding and the DT node only once it is supported.

Quentin
-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
