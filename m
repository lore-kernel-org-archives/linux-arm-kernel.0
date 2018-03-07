From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 7 Mar 2018 12:22:15 +0100
Subject: [PATCH v5 0/6] dt-bindings: add bindings for USB physical
 connector
In-Reply-To: <b64d77c1-c80f-1bd9-a599-3027424ec667@samsung.com>
References: <CGME20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e@eucas1p1.samsung.com>
 <20180227071134.28063-1-a.hajda@samsung.com>
 <c4a773b6-a24e-4e72-3cc4-ebafeac232c1@samsung.com>
 <5A9F4A7D.9020409@samsung.com> <5A9F6F29.5020501@samsung.com>
 <b64d77c1-c80f-1bd9-a599-3027424ec667@samsung.com>
Message-ID: <CAJKOXPfWwD-wYOzYacH4j7gfgDGh5MPAhXTR46wbYU=pw3zEhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 7, 2018 at 12:13 PM, Andrzej Hajda <a.hajda@samsung.com> wrote:
> Hi Chanwoo, Archit,
>
> On 07.03.2018 05:48, Chanwoo Choi wrote:
>> On 2018? 03? 07? 11:12, Chanwoo Choi wrote:
>>> Hi Rob and Andrzej,
>>>
>>> On 2018? 03? 06? 21:53, Andrzej Hajda wrote:
>>>> Hi Rob, Chanwoo, Krzysztof,
>>>>
>>>>
>>>> On 27.02.2018 08:11, Andrzej Hajda wrote:
>>>>> Hi,
>>>>>
>>>>> Thanks for reviews of previous iterations.
>>>>>
>>>>> This patchset introduces USB physical connector bindings, together with
>>>>> working example.
>>>>> I have removed RFC prefix - the patchset seems to be heading
>>>>> to a happy end :)
>>>>>
>>>>> v5: fixed extra parenthesis in dts, renamed extcon function.
>>>>> v4: improved binding descriptions, added missing reg in dts.
>>>>> v3: Separate binding for Samsung 11-pin connector, added full-blown USB-C
>>>>>     example.
>>>>> v2: I have addressed comments by Rob and Laurent, thanks
>>>>>
>>>>> Changes in datail are described in the patches.
>>>>>
>>>>> Regards
>>>>> Andrzej
>>>>>
>>>>>
>>>>> Andrzej Hajda (5):
>>>>>   dt-bindings: add bindings for USB physical connector
>>>>>   dt-bindings: add bindings for Samsung micro-USB 11-pin connector
>>>>>   arm64: dts: exynos: add micro-USB connector node to TM2 platforms
>>>>>   arm64: dts: exynos: add OF graph between MHL and USB connector
>>>>>   extcon: add possibility to get extcon device by OF node
>>>>>
>>>>> Maciej Purski (1):
>>>>>   drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL
>>>> It looks like all patches received R-B or acks (I forgot add Krzysztof's
>>>> acks for dts part).
>>>> Now I have a question how to merge them.
>>>> The only functional dependency is between bridge and extcon, and from
>>>> the formal PoV bindings should be merged 1st.
>>>> I can merge it:
>>>> 1. All patches via drm-misc tree.
>>>> 2. All patches except dts via drm-misc, and Krzysztof will merge dts via
>>>> samsung-soc tree.
>>>>
>>>> Is it OK, for all? Better ideas?
>>> Krzysztof picked the dts patches. I'll make the immutable branch based on v4.16-rc1
>>> and apply them except for dts patchs. And I'll send the immutable branch to Rob and Andrzej.
>>>
>>>
>> I made the immutable branch[1] as following: If you agree, I'll send pull request.
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git/log/?h=ib-extcon-drm-dt-v4.17
>>
>> Or you can make the immutable branch and send pull request to Rob and me.
>>
>
> It seems you took v5 instead of v6 version of extcon patch.

I also took v5:
https://patchwork.kernel.org/patch/10244407/
https://patchwork.kernel.org/patch/10244431/

There was no v6 in samsung-soc patchwork. Is it a problem for DTS?

BR,
Krzysztof
