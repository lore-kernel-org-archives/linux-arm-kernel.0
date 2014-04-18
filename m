From: ipaton0@gmail.com (Iain Paton)
Date: Fri, 18 Apr 2014 14:25:52 +0100
Subject: [PATCH] ARM: imx6: clk: i.MX6 DualLite/Solo i2c4 clock
In-Reply-To: <20140417130004.GC22160@dragon>
References: <534ECCF4.9040108@gmail.com> <534FCBE7.6020007@mentor.com>
 <20140417130004.GC22160@dragon>
Message-ID: <535127E0.2070106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/04/14 14:00, Shawn Guo wrote:
> On Thu, Apr 17, 2014 at 03:41:11PM +0300, Vladimir Zapolskiy wrote:
>> On 04/16/14 21:33, Iain Paton wrote:
>>> -	clk[ecspi5]       = imx_clk_gate2("ecspi5",        "ecspi_root",        base + 0x6c, 8);
>>> +	if (cpu_is_imx6dl())
>>> +		/*
>>> +		 * ecspi5 is replaced with i2c4 on imx6dl&  imx6s
>>> +		 */
>>> +		clk[ecspi5] = imx_clk_gate2("i2c4",        "ipg_per",           base + 0x6c, 8);
>>
>> Is it good enough to reuse ecspi5 enum value here or may it be
>> better to introduce a new one i2c4 equal to ecspi5?
> 
> With the comment in there, it's just fine to reuse the enum, I think.

I wasn't sure about that, but couldn't find anywhere else the enum was used. In 
the dts the clock is simply referenced as <&clks 116> so you have to work that
back manually.

If you think it's worth it to add something to 
Documentation/devicetree/bindings/clock/imx6q-clock.txt so that the difference 
is documented I can send a patch for that.

Iain
