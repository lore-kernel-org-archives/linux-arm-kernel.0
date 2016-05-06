From: david.wu@rock-chips.com (David.Wu)
Date: Fri, 6 May 2016 14:09:48 +0800
Subject: [PATCH v7 7/9] dt-bindings: i2c: rk3x: add support for rk3399
In-Reply-To: <20160505221212.GA26820@rob-hp-laptop>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
 <1462372523-6444-1-git-send-email-david.wu@rock-chips.com>
 <20160505221212.GA26820@rob-hp-laptop>
Message-ID: <572C352C.50303@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

? 2016/5/6 6:12, Rob Herring ??:
> On Wed, May 04, 2016 at 10:35:23PM +0800, David Wu wrote:
>> The bus clock and function clock are separated at rk3399,
>> and others use one clock as the bus clock and function clock.
>>
>> Signed-off-by: David Wu <david.wu@rock-chips.com>
>> ---
>>   Documentation/devicetree/bindings/i2c/i2c-rk3x.txt | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
>> index 0b4a85f..82b6f6b 100644
>> --- a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
>> @@ -6,10 +6,20 @@ RK3xxx SoCs.
>>   Required properties :
>>
>>    - reg : Offset and length of the register set for the device
>> - - compatible : should be "rockchip,rk3066-i2c", "rockchip,rk3188-i2c",
>> -		"rockchip,rk3228-i2c" or "rockchip,rk3288-i2c".
>> + - compatible: should be one of the followings
>
> s/followings/following:/
>
>> +   - "rockchip,rk3066-i2c": for rk3066
>> +   - "rockchip,rk3188-i2c": for rk3188
>> +   - "rockchip,rk3228-i2c": for rk3228
>> +   - "rockchip,rk3288-i2c": for rk3288
>> +   - "rockchip,rk3399-i2c": for rk3399
>>    - interrupts : interrupt number
>> - - clocks : parent clock
>> + - clocks: See ../clock/clock-bindings.txt
>> +   - For older hardware (rk3066, rk3188, rk3228, rk3288):
>> +     - There is one clock that's used both to derive the functional clock
>> +       for the device and as the bus clock.  REQUIRED.
>
> This is the required section, so REQUIRED is redundant.


>
>> +   - For newer hardware (rk3399): specify by name
>> +     - "i2c": REQUIRED. This is used to derive the functional clock.
>> +     - "pclk": REQUIRED. This is the bus clock.equired on RK3066, RK3188 :
>
> This doesn't make sense. The first line says this applies to rk3399, but
> then here it is talking about other parts.
>
> And there's a typo.
>

Okay, I will remove the "equired on RK3066, RK3188 :".

>>
>>   Required on RK3066, RK3188 :
>>
>> --
>> 1.9.1
>>
>>
>
>
>
