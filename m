From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Mon, 13 Jul 2015 12:54:46 +0530
Subject: [PATCH 3/6] mfd: devicetree: bindings: 88pm800: Add DT property
 for 32KHz output enable
In-Reply-To: <55A0C1B8.4030402@samsung.com>
References: <1436442431-3471-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1436442431-3471-4-git-send-email-vaibhav.hiremath@linaro.org>
 <55A0C1B8.4030402@samsung.com>
Message-ID: <55A367BE.6040103@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Saturday 11 July 2015 12:41 PM, Krzysztof Kozlowski wrote:
> W dniu 09.07.2015 o 20:47, Vaibhav Hiremath pisze:
>> 88PM800 family of device supports output of 32KHz clock (low jitter)
>> on CLK32K2/3 pin which can be supplied to other peripherals on the board.
>>
>> This patch adds the devicetree binding to enable this feature.
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/mfd/88pm800.txt | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/88pm800.txt b/Documentation/devicetree/bindings/mfd/88pm800.txt
>> index dec842f..ae1311c 100644
>> --- a/Documentation/devicetree/bindings/mfd/88pm800.txt
>> +++ b/Documentation/devicetree/bindings/mfd/88pm800.txt
>> @@ -9,6 +9,12 @@ Required parent device properties:
>>   - #interrupt-cells 	: should be 1.
>>   			  The cell is the 88pm80x local IRQ number
>>
>> +Optional properties :
>> + - marvell,88pm800-32khz-xolj-out-en	: If set, driver will enable low jitter
>> +   version of 32Khz clock output on
>
> I am not sure if I understand it correctly. The hardware always has such
> clocks and you only want to enable/disable it in DT? Any reasons why
> these should not be enabled always?
>

Small amount of Power savings...
Although currently I do not have power numbers to justify this.

As per spec, (it only talks about power consumption in power down state)

Power-down State => VSYS > 2.8   => 4.5 ?A
                     CLK32K2 = 0  => 18 ?W

> Enabling it in DT does not look like a job for DT. Maybe you there
> should be just a clock driver (clock provider)?
>

It's init time (and one time) settings, wouldn't clock-provider
be overkill for this?


Thanks,
Vaibhav
