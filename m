From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 17 Jul 2015 09:26:40 +0200
Subject: [PATCH v2 4/4] mfd: max77686: Split out regulator part from the
 DT binding
In-Reply-To: <CAJKOXPdTKP21eO0dcD_Ec0YA8H5Jhy2YAFjS8hnQLgVe5cCNrA@mail.gmail.com>
References: <1437114567-17629-1-git-send-email-javier@osg.samsung.com>
 <1437114567-17629-5-git-send-email-javier@osg.samsung.com>
 <CAJKOXPe8rDLCt+Za+Qzkkd4JnFoyKtsFTmMbJL6+3Ark8qFYiQ@mail.gmail.com>
 <55A8A4BE.1030904@osg.samsung.com>
 <CAJKOXPdih+qqGnEZub-hqeVF6POSuSGN-OWnLCgN9cW_5sYb+A@mail.gmail.com>
 <55A8A7E2.7020201@osg.samsung.com>
 <CAJKOXPdTKP21eO0dcD_Ec0YA8H5Jhy2YAFjS8hnQLgVe5cCNrA@mail.gmail.com>
Message-ID: <55A8AE30.6040908@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 07/17/2015 09:11 AM, Krzysztof Kozlowski wrote:
> 2015-07-17 15:59 GMT+09:00 Javier Martinez Canillas <javier@osg.samsung.com>:
>> Hello Krzysztof,
>>
>> On 07/17/2015 08:49 AM, Krzysztof Kozlowski wrote:
>>> 2015-07-17 15:46 GMT+09:00 Javier Martinez Canillas <javier@osg.samsung.com>:
>>>> Hello Krzysztof,
>>>>
>>>> On 07/17/2015 08:42 AM, Krzysztof Kozlowski wrote:
>>>>> 2015-07-17 15:29 GMT+09:00 Javier Martinez Canillas <javier@osg.samsung.com>:
>>>>>> The Maxim MAX77686 PMIC is a multi-function device with regulators,
>>>>>> clocks and a RTC. The DT bindings for the clocks are in a separate
>>>>>> file but the bindings for the regulators are inside the mfd part.
>>>>>>
>>>>>> To make it consistent with the clocks portion of the binding and
>>>>>> because is more natural to look for regulator bindings under the
>>>>>> bindings/regulator sub-directory, split the regulator portion of
>>>>>> the DT binding and add it as a separate file.
>>>>>>
>>>>>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>>>>>
>>>>>> ---
>>>>>>
>>>>>> Changes in v2:
>>>>>> - Use a generic name for the max77686 node in the regulator example.
>>>>>>
>>>>>>  Documentation/devicetree/bindings/mfd/max77686.txt | 58 +-----------------
>>>>>>  .../devicetree/bindings/regulator/max77686.txt     | 71 ++++++++++++++++++++++
>>>>>>  2 files changed, 74 insertions(+), 55 deletions(-)
>>>>>>  create mode 100644 Documentation/devicetree/bindings/regulator/max77686.txt
>>>>>
>>>>> Putting regulator bindings under regulator directory seems logical so
>>>>> I am fine with it.
>>>>>
>>>>> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>>>>
>>>>
>>>> Thanks a lot for your review. For completeness, I talked with Lee Jones
>>>> over IRC yesterday asking him his opinion on whether MFD DT binding doc
>>>> should contain all the info or if it should be split across different
>>>> subsystems and he prefers the later. That's why I re-spun this series.
>>>
>>> Okay, this sounds good.
>>>
>>> One more thing - can you update the maintainers file? The bindings
>>> documentation is mentioned there for max77686.
>>>
>>
>> Sure, I see that also the max77802 files are missing in that section.
>> I'll included that as well.
> 
> The max717802 are not there because they are not part of this
> maintainership :) . I wasn't involved in development of them (except
> reviewing) so I did not put myself as their maintainer.
>

Fair enough, I guess I should add an entry for max77802 then and
volunteer myself as maintainer since after all I added the driver.
 
>> But I'll wait to see if Lee pick this
>> series before posting the patch for MAINTAINERS.
> 
> I think the maintainers should be updated in the same patchset (or
> even patch) to keep the state consistent.
>

Ok, I'll post a patch then to be applied on top of this series. I
could re-spin the whole series and add it to $subject but I'm not
sure if is worth it since it's only documentation and I prefer to
avoid spaming Lee and Mark with yet another revision.

> Best regards,
> Krzysztof
>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
