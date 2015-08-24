From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Mon, 24 Aug 2015 20:24:10 +0530
Subject: [PATCH-v3 1/2] mfd: devicetree: bindings: 88pm800: Add DT property
 for dual phase enable
In-Reply-To: <20150824130205.GE3237@x1>
References: <1440420006-31556-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1440420006-31556-2-git-send-email-vaibhav.hiremath@linaro.org>
 <20150824130205.GE3237@x1>
Message-ID: <55DB3012.6010904@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 24 August 2015 06:32 PM, Lee Jones wrote:
> On Mon, 24 Aug 2015, Vaibhav Hiremath wrote:
>
>> 88PM860 family of device supports dual phase mode on BUCK1 supply
>> providing total 6A capacity.
>> Note that by default they operate independently with 3A capacity.
>>
>> This patch updates the devicetree binding with DT property
>> to enable dual-phase mode on BUCK1.
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/mfd/88pm800.txt | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/88pm800.txt b/Documentation/devicetree/bindings/mfd/88pm800.txt
>> index dec842f..2c82fcb 100644
>> --- a/Documentation/devicetree/bindings/mfd/88pm800.txt
>> +++ b/Documentation/devicetree/bindings/mfd/88pm800.txt
>> @@ -9,6 +9,12 @@ Required parent device properties:
>>   - #interrupt-cells 	: should be 1.
>>   			  The cell is the 88pm80x local IRQ number
>>
>> +Optional properties :
>> +- marvell,88pm860-buck1-dualphase-en  : If set, enable dual phase on BUCK1,
>> +  providing 6A capacity.
>> +  Without this both BUCK1A and BUCK1B operates independently with 3A capacity.
>> +  (This property is only applicable to 88PM860)
>
> This will require a Regulator Ack.
>
> My suggestion would be to remove the 'buck' number, as the same
> property could be used on any Buck, and remove the '-en' part, as
> this is implied.
>

Ok, Will do it in next version.

Mark,

Any comments here before I spin V4.

Thanks,
Vaibhav
