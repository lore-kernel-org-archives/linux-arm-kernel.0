From: javierm@redhat.com (Javier Martinez Canillas)
Date: Tue, 12 Dec 2017 11:40:57 +0100
Subject: [PATCH v2] ARM: dts: exynos: Enable Mixer node for Exynos5800
 Peach Pi machine
In-Reply-To: <CAJKOXPc1_n2cdgjuFbA9jNdcSXxfr8Zjf=fUx_jt_N3+LP0n8A@mail.gmail.com>
References: <20171212074208.30753-1-javierm@redhat.com>
 <CAJKOXPc1rJCWABXUuyU2MKxnLY-MptrM9Mm0HyHVCJn870R+sg@mail.gmail.com>
 <CAJKOXPc1_n2cdgjuFbA9jNdcSXxfr8Zjf=fUx_jt_N3+LP0n8A@mail.gmail.com>
Message-ID: <fe7b9dd6-c169-32bf-50c5-dc708872f977@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 12/12/2017 11:09 AM, Krzysztof Kozlowski wrote:
> On Tue, Dec 12, 2017 at 10:55 AM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On Tue, Dec 12, 2017 at 8:42 AM, Javier Martinez Canillas
>> <javierm@redhat.com> wrote:
>>> Commit 1cb686c08d12 ("ARM: dts: exynos: Add status property to Exynos 542x
>>> Mixer nodes") disabled the Mixer node by default in the DTSI and enabled
>>> for each Exynos 542x DTS. But unfortunately it missed to enable it for the
>>> Exynos5800 Peach Pi machine, since the 5800 is also an 542x SoC variant.
>>>
>>> Fixes: 1cb686c08d12 ("ARM: dts: exynos: Add status property to Exynos 542x Mixer nodes")
>>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>>> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>
>>> ---
>>>
>>> Changes in v2:
>>> - Remove RFT tag.

I removed the tag because Marek acked it and the patch has merits on its own
regardless of the boot issue (it just introduces a change that was missed in
the mentioned commit).
>>
>> Thanks guys! However I still would like to see a tested-by for this on
>> Peach Pi (AFAIU, Marek's only acked the code/solution).
> 
> On the other hand I could just apply it for my for-next branch and
> we'll see if it fixes kernel-ci boot tests... Not a nice way of

As Marek said this probably won't solve the issue, or at best it would just
mask it. Seems the problem is on the probe deferral path in exynos-drm driver.

> testing but apparently no one has Peach Pi.
>

I do have one, but I haven't used it for months and don't have time to setup
a test environment now. I will probably do that this weekend to dig deeper.

> Best regards,
> Krzysztof
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
