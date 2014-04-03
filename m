From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 03 Apr 2014 09:40:42 +0000
Subject: [PATCH 2/3] ARM: dts: document the berlin enable-method property
In-Reply-To: <533D268E.7070502@free-electrons.com>
References: <1396512496-8030-1-git-send-email-antoine.tenart@free-electrons.com>	<1396512496-8030-3-git-send-email-antoine.tenart@free-electrons.com>
 <20140403162202.79b63729@xhacker> <533D21AF.2070508@free-electrons.com>
 <533D268E.7070502@free-electrons.com>
Message-ID: <533D2C9A.6010302@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2014 09:14 AM, Antoine T?nart wrote:
> On 03/04/2014 10:54, Antoine T?nart wrote:
>> On 03/04/2014 10:22, Jisheng Zhang wrote:
>>> On Thu, 3 Apr 2014 01:08:15 -0700
>>> Antoine T?nart <antoine.tenart@free-electrons.com> wrote:
>>>
>>>> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
>>>> ---
>>>>   Documentation/devicetree/bindings/arm/cpus.txt | 2 ++
>>>>   1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt
>>>> b/Documentation/devicetree/bindings/arm/cpus.txt index
>>>> 333f4aea3029..a9e42a2dbc99 100644 ---
>>>> a/Documentation/devicetree/bindings/arm/cpus.txt +++
>>>> b/Documentation/devicetree/bindings/arm/cpus.txt @@ -185,6 +185,8 @@
>>>> nodes
>>>> to be present and contain the properties described below.
>>>> "qcom,gcc-msm8660"
>>>>                   "qcom,kpss-acc-v1"
>>>>                   "qcom,kpss-acc-v2"
>>>> +                "marvell,88de31-smp" - cpu-core handling for
>>>
>>> why not "marvell,berlin-smp"?
>>
>> We have SMP on the BG2 and the BG2Q currently. Future boards may not be
>> compatible with this method (BG3 ?), I think "marvell,berlin-smp" is too
>> generic.
>>
>> We could use "marvell,88de31xx-smp" as Alexandre suggested.
>
> "marvell,88de31xx-smp" is not a good choice too, since futur SoC may
> match the "xx" and not use this method. A better way should be to use
> the first SoC implementing the feature, so "marvell,88de3100".

Never introduce the SoC numbers, we have chosen to stick with
berlin2{,cd,q} so use that.

Given the comment from Mark Rutland and Russell King here[1], I'd rather
concentrate on a proper SMP implementation. Unfortunately, I haven't
found a good documentation about the requirements nor call sequence -
but I haven't looked hard.

Having said that, can we postpone the DT enable method patches until
we agreed on a better SMP implementation?

Sebastian

[1] http://www.spinics.net/lists/arm-kernel/msg318585.html
