From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Mon, 16 Jan 2017 09:15:15 -0800
Subject: [PATCH v3 06/24] ARM: dts: imx6-sabrelite: add OV5642 and OV5640
 camera sensors
In-Reply-To: <1484571323.8415.98.camel@pengutronix.de>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-7-git-send-email-steve_longerbeam@mentor.com>
 <1484309021.31475.29.camel@pengutronix.de>
 <1bb64209-7c58-fe10-3db9-c5b8103eda90@gmail.com>
 <1484571323.8415.98.camel@pengutronix.de>
Message-ID: <83a5f605-2bdb-76a1-28c8-620e829226f3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/16/2017 04:55 AM, Philipp Zabel wrote:
> On Fri, 2017-01-13 at 15:04 -0800, Steve Longerbeam wrote:
>
>>>> @@ -299,6 +326,52 @@
>>>>    	pinctrl-names = "default";
>>>>    	pinctrl-0 = <&pinctrl_i2c2>;
>>>>    	status = "okay";
>>>> +
>>>> +	ov5640: camera at 40 {
>>>> +		compatible = "ovti,ov5640";
>>>> +		pinctrl-names = "default";
>>>> +		pinctrl-0 = <&pinctrl_ov5640>;
>>>> +		clocks = <&mipi_xclk>;
>>>> +		clock-names = "xclk";
>>>> +		reg = <0x40>;
>>>> +		xclk = <22000000>;
>>> This is superfluous, you can use clk_get_rate on mipi_xclk.
>> This property is actually there to tell the driver what to set the
>> rate to, with clk_set_rate(). So you are saying it would be better
>> to set the rate in the device tree and the driver should only
>> retrieve the rate?
> Yes. Given that this is a reference clock input that is constant on a
> given board and never changes during runtime, I think this is the
> correct way. The clock will be fixed rate on most boards, I assume.

Ok, that makes sense, I'll make that change.

Steve
