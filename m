From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 6 Mar 2018 14:08:24 +0100
Subject: [PATCH v5 0/6] dt-bindings: add bindings for USB physical
 connector
In-Reply-To: <c4a773b6-a24e-4e72-3cc4-ebafeac232c1@samsung.com>
References: <CGME20180227071137eucas1p104aeeb0fd926fe985e250174d9d65b2e@eucas1p1.samsung.com>
 <20180227071134.28063-1-a.hajda@samsung.com>
 <c4a773b6-a24e-4e72-3cc4-ebafeac232c1@samsung.com>
Message-ID: <CAJKOXPdne8ETZWg2Grv81E19Hsxt3bCHLpbsTdfKafwy0XNsyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 6, 2018 at 1:53 PM, Andrzej Hajda <a.hajda@samsung.com> wrote:
> Hi Rob, Chanwoo, Krzysztof,
>
>
> On 27.02.2018 08:11, Andrzej Hajda wrote:
>> Hi,
>>
>> Thanks for reviews of previous iterations.
>>
>> This patchset introduces USB physical connector bindings, together with
>> working example.
>> I have removed RFC prefix - the patchset seems to be heading
>> to a happy end :)
>>
>> v5: fixed extra parenthesis in dts, renamed extcon function.
>> v4: improved binding descriptions, added missing reg in dts.
>> v3: Separate binding for Samsung 11-pin connector, added full-blown USB-C
>>     example.
>> v2: I have addressed comments by Rob and Laurent, thanks
>>
>> Changes in datail are described in the patches.
>>
>> Regards
>> Andrzej
>>
>>
>> Andrzej Hajda (5):
>>   dt-bindings: add bindings for USB physical connector
>>   dt-bindings: add bindings for Samsung micro-USB 11-pin connector
>>   arm64: dts: exynos: add micro-USB connector node to TM2 platforms
>>   arm64: dts: exynos: add OF graph between MHL and USB connector
>>   extcon: add possibility to get extcon device by OF node
>>
>> Maciej Purski (1):
>>   drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL
>
> It looks like all patches received R-B or acks (I forgot add Krzysztof's
> acks for dts part).
> Now I have a question how to merge them.
> The only functional dependency is between bridge and extcon, and from
> the formal PoV bindings should be merged 1st.
> I can merge it:
> 1. All patches via drm-misc tree.
> 2. All patches except dts via drm-misc, and Krzysztof will merge dts via
> samsung-soc tree.

2) option please. The DTS should always go through arm-soc because it
is independent of driver code. I'll take the DTS today.

Best regards,
Krzysztof
