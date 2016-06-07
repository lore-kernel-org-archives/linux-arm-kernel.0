From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 07 Jun 2016 11:29:02 +0200
Subject: [PATCH v3 06/12] power: pwrseq: simple: Add support for regulator
 and generic property
In-Reply-To: <20160603020218.GA19436@rob-hp-laptop>
References: <1464768141-25420-1-git-send-email-k.kozlowski@samsung.com>
 <1464768141-25420-7-git-send-email-k.kozlowski@samsung.com>
 <20160603020218.GA19436@rob-hp-laptop>
Message-ID: <575693DE.2010603@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/2016 04:02 AM, Rob Herring wrote:
>>  Optional properties:
>>  - reset-gpios : contains a list of GPIO specifiers. The reset GPIOs are asserted
>> @@ -16,6 +22,7 @@ Optional properties:
>>    See ../clocks/clock-bindings.txt for details.
>>  - clock-names : Must include the following entry:
>>    "ext_clock" (External clock provided to the card).
>> +- ext-supply : External regulator supply
> 
> What happens when there are 2 supplies?
> 
> I'd prefer the name not be genericish and use the real supply names. 
> Then the power seq code should just turn on all supplies it finds. If 
> the order or timing to turn on matters, then sorry, no generic sequence.

I think the generic part for regulators might be a problem. Regulator
API requires a name for the supply... it cannot get "something" or
"everything".

The driver could attach itself to any kind of node (where power-sequence
property exists) so the supply name depends on the bindings of device
(not bindings of power sequence driver).

The power sequence driver could however iterate over child properties
and get the names of all supplies. It is a little bit ugly...

Best regards,
Krzysztof
