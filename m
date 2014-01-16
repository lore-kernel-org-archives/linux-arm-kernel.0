From: voice.shen@atmel.com (Bo Shen)
Date: Thu, 16 Jan 2014 09:38:52 +0800
Subject: [PATCH 3/3] Binding: atmel-wm8904: add option to choose clock
In-Reply-To: <52D6C2A1.4080405@atmel.com>
References: <1389669956-2304-1-git-send-email-voice.shen@atmel.com>
 <1389669956-2304-4-git-send-email-voice.shen@atmel.com>
 <52D6C2A1.4080405@atmel.com>
Message-ID: <52D7382C.4080705@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On 01/16/2014 01:17 AM, Nicolas Ferre wrote:
> On 14/01/2014 04:25, Bo Shen :
>> Add the option to choose clock output on which pin connect to SSC.
>> Default is on TK pin to SSC, add clk_from_rk_pin option, the clock
>
> Please do not use "_" in DT properties. It is a common pattern to use
> "-" instead.

OK, I will use "-" instead in next version.

>> is on RK pin to SSC.
>>
>> Signed-off-by: Bo Shen <voice.shen@atmel.com>
>> ---
>>
>>   Documentation/devicetree/bindings/sound/atmel-wm8904.txt | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/atmel-wm8904.txt b/Documentation/devicetree/bindings/sound/atmel-wm8904.txt
>> index 8bbe50c..68a5c1a 100644
>> --- a/Documentation/devicetree/bindings/sound/atmel-wm8904.txt
>> +++ b/Documentation/devicetree/bindings/sound/atmel-wm8904.txt
>> @@ -33,6 +33,8 @@ Required properties:
>>
>>   Optional properties:
>>     - pinctrl-names, pinctrl-0: Please refer to pinctrl-bindings.txt
>> +  - clk_from_rk_pin: according to hardware design, clk privide on rk pin
>
> typo + more description is needed:
> Please tell that it is a boolean property, that by default it is using
> the TK pin (like in the commit message in fact).

OK, I will add more description for it.

Thanks

> Bye,
>
>> +    to ssc device
>>
>>   Example:
>>   sound {
>>
>
>

Best Regards,
Bo Shen
