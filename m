From: Claudiu.Beznea@microchip.com (m18063)
Date: Fri, 3 Mar 2017 11:53:17 +0200
Subject: [PATCH 2/2] drivers: pwm: pwm-atmel: enable pwm on sama5d2
In-Reply-To: <20170303062120.uippq2ajtnrxfcx5@rob-hp-laptop>
References: <1488278415-2786-1-git-send-email-claudiu.beznea@microchip.com>
 <1488278415-2786-3-git-send-email-claudiu.beznea@microchip.com>
 <20170303062120.uippq2ajtnrxfcx5@rob-hp-laptop>
Message-ID: <a4ce6e72-bc67-cb53-6c45-910a7c1497e0@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On 03.03.2017 08:21, Rob Herring wrote:
> On Tue, Feb 28, 2017 at 12:40:15PM +0200, Claudiu Beznea wrote:
>> sama5d2 can use the same atmel_pwm_data as sama5d3.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>>  Documentation/devicetree/bindings/pwm/atmel-pwm.txt | 1 +
>>  drivers/pwm/pwm-atmel.c                             | 3 +++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/atmel-pwm.txt b/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
>> index 02331b9..c8c831d 100644
>> --- a/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
>> +++ b/Documentation/devicetree/bindings/pwm/atmel-pwm.txt
>> @@ -4,6 +4,7 @@ Required properties:
>>    - compatible: should be one of:
>>      - "atmel,at91sam9rl-pwm"
>>      - "atmel,sama5d3-pwm"
>> +    - "atmel,sama5d2-pwm"
> Perhaps sama5d3 should be a fallback, then you don't need a driver 
> change.
>
> Rob

sama5d2 PWM controller have additional features. We intend to support
some of these. This is why I choose to add specific compatible string
for it.

Thank you,
Claudiu Beznea
