From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 17 Mar 2016 19:21:23 +0000
Subject: [PATCH v2 02/18] dt-bindings: timer: sp804: add timer-width
 property
In-Reply-To: <CAL_JsqKRjFDNmGjkPfJ-BKXG8ekNzUgear3uLzsFYbZU7Zph7w@mail.gmail.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457519060-6038-1-git-send-email-narmstrong@baylibre.com>
 <1457519060-6038-3-git-send-email-narmstrong@baylibre.com>
 <20160317170926.GA28934@rob-hp-laptop> <56EAF212.7020700@arm.com>
 <CAL_JsqKRjFDNmGjkPfJ-BKXG8ekNzUgear3uLzsFYbZU7Zph7w@mail.gmail.com>
Message-ID: <56EB03B3.3070106@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/03/16 19:00, Rob Herring wrote:
> On Thu, Mar 17, 2016 at 1:06 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>> Hi Rob,
>>
>> On 17/03/16 17:09, Rob Herring wrote:
>>>
>>> On Wed, Mar 09, 2016 at 11:24:04AM +0100, Neil Armstrong wrote:
>>>>
>>>> Add timer-width optional property to specify a different vendor
>>>> specific timer counter bit-width.
>>>>
>>>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/timer/arm,sp804.txt | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/timer/arm,sp804.txt
>>>> b/Documentation/devicetree/bindings/timer/arm,sp804.txt
>>>> index 5cd8eee7..141e143 100644
>>>> --- a/Documentation/devicetree/bindings/timer/arm,sp804.txt
>>>> +++ b/Documentation/devicetree/bindings/timer/arm,sp804.txt
>>>> @@ -17,6 +17,8 @@ Optional properties:
>>>>    - arm,sp804-has-irq = <#>: In the case of only 1 timer irq line
>>>> connected, this
>>>>          specifies if the irq connection is for timer 1 or timer 2. A
>>>> value of 1
>>>>          or 2 should be used.
>>>> +- arm,timer-width: Should contain the width in number of bits of the
>>>> counter,
>>>> +       is considered by default 32 but can be changed for vendor
>>>> variants.
>>>
>>>
>>> That would not be an SP804 nor would the vendor be ARM in that case. So
>>> add a new compatible string for the vendor that decided to hack up ARM's
>>> IP block.
>>
>>
>> By all accounts this is some ancient reference design[1] which later evolved
>> _into_ the SP804, so that vendor would probably still be ARM ;)
>
> Right.
>
>> A separate compatible string would indeed make more sense, though. Both
>> semantically and in terms of letting the driver account for the differences
>> automatically.
>>
>> Robin.
>>
>> [1]:http://infocenter.arm.com/help/topic/com.arm.doc.ddi0170a/I350250.html
>
> Humm, same as integrator timers perhaps?

Having had a quick look, what the Integrator/AP manual describes 
certainly smells like the same basic block as the "AMBA Timer" - 16 bit 
counters and the same control register layout - albeit in a mutant 
triple-timer version with a bigger offset between each register set. 
Integrator/CP, on the other hand, looks much more SP804-like.

Robin.
