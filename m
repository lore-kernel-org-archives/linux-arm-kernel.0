From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 25 Oct 2016 17:52:36 +0100
Subject: [PATCH 3/4] dt-bindings: Update domain-idle-state binding to use
 correct compatibles
In-Reply-To: <20161025162440.GA48977@linaro.org>
References: <1477409199-52182-1-git-send-email-lina.iyer@linaro.org>
 <1477409199-52182-4-git-send-email-lina.iyer@linaro.org>
 <383a62dd-b4d7-f764-baf1-ff73691b3cbc@arm.com>
 <20161025162440.GA48977@linaro.org>
Message-ID: <21245968-30ff-a55a-7130-8439097ee8f4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/10/16 17:24, Lina Iyer wrote:
> On Tue, Oct 25 2016 at 09:59 -0600, Sudeep Holla wrote:
>>
>>
>> On 25/10/16 16:26, Lina Iyer wrote:
>>> Update domain-idle-state binding to use "domain-idle-state" compatible
>>> from Documentation/devicetree/bindings/arm/idle-states.txt.
>>>
>>> Cc: <devicetree@vger.kernel.org>
>>> Cc: Rob Herring <robh@kernel.org>
>>> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
>>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>> ---
>>> Documentation/devicetree/bindings/power/power_domain.txt | 9 +++++----
>>> 1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt
>>> b/Documentation/devicetree/bindings/power/power_domain.txt
>>> index e165036..6fb53a3 100644
>>> --- a/Documentation/devicetree/bindings/power/power_domain.txt
>>> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
>>> @@ -30,8 +30,9 @@ Optional properties:
>>>    available in the next section.
>>>
>>> - domain-idle-states : A phandle of an idle-state that shall be
>>> soaked into a
>>> -                generic domain power state. The idle state
>>> definitions are
>>> -                compatible with arm,idle-state specified in [1].
>>> +                generic domain power state. The idle state
>>> definitions must be
>>> +                compatible with "domain-idle-state"
>>
>> I would reword the below a bit different so that it's flexible to be
>> reused without "arm,idle-state".
>>
>>> as well as
>>> +                "arm,idle-state" as defined in [1].
>>
>> 'Idle states that are "arm,idle-state" compatible are generally
>> "domain-idle-state" compatible as well if it's a PM domain.'
>>
> I believe we should have both compatible strings. Per [1], any CPU that
> follows the idle state compatible *must* have "arm,idle-state" as a
> compatible.

Yes that's implicit for a CPU device. But generic power domain bindings
should not have that explicitly as it *can be* used for non CPU device.

> Since we are re-using the same compatible, its only correct
> that we retain what is already spec'd up in [1] and in addition provide
> this new compatible.
>

Yes [1] applies for *CPUs only* while this applies for *any device* and
*any power domain*, so I would drop *must have* "arm,idle-state" here
to keep this generic based on my understanding on how compatibles work.

-- 
Regards,
Sudeep
