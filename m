From: david.wu@rock-chips.com (David.Wu)
Date: Thu, 12 May 2016 09:14:04 +0800
Subject: [PATCH v8 6/8] dt-bindings: i2c: rk3x: add support for rk3399
In-Reply-To: <CAD=FV=VzL8AfzUnPYgsf_NqPgbp2_o_qJC7-DWHmekWVQ-Es=A@mail.gmail.com>
References: <1462908252-27016-1-git-send-email-david.wu@rock-chips.com>
 <1462908647-27236-1-git-send-email-david.wu@rock-chips.com>
 <CAD=FV=VzL8AfzUnPYgsf_NqPgbp2_o_qJC7-DWHmekWVQ-Es=A@mail.gmail.com>
Message-ID: <5733D8DC.1010603@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

? 2016/5/12 0:35, Doug Anderson ??:
> Hi,
>
> On Tue, May 10, 2016 at 12:30 PM, David Wu <david.wu@rock-chips.com> wrote:
>> The bus clock and function clock are separated at rk3399,
>> and others use one clock as the bus clock and function clock.
>>
>> Signed-off-by: David Wu <david.wu@rock-chips.com>
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>> ---
>> Change in v8:
>> - remove error description.
>>
>>   Documentation/devicetree/bindings/i2c/i2c-rk3x.txt | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
>> index 0b4a85f..5429301 100644
>> --- a/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
>> +++ b/Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
>> @@ -6,10 +6,20 @@ RK3xxx SoCs.
>>   Required properties :
>>
>>    - reg : Offset and length of the register set for the device
>> - - compatible : should be "rockchip,rk3066-i2c", "rockchip,rk3188-i2c",
>> -               "rockchip,rk3228-i2c" or "rockchip,rk3288-i2c".
>> + - compatible: should be one of the following:
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
>> +       for the device and as the bus clock.
>> +   - For newer hardware (rk3399): specified by name
>> +     - "i2c": REQUIRED. This is used to derive the functional clock.
>> +     - "pclk": REQUIRED. This is the bus clock.
>
> Depending on what Rob thinks, it might make sense to remove the above
> two "REQUIRED" bits.  That would match his earlier feedback since
> we're still in the "Required" section and thus it is redundant.
>

Okay, i make a little misunderstand for that, so i will fix it in next 
version.

> -Doug
>
>
>
