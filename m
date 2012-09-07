From: l.krishna@samsung.com (Leela Krishna Amudala)
Date: Fri, 7 Sep 2012 09:16:42 +0530
Subject: [PATCH V4 2/2] video: drm: exynos: Add device tree support
In-Reply-To: <5048837B.6020903@samsung.com>
References: <1346859555-13527-1-git-send-email-l.krishna@samsung.com>
 <1346859555-13527-3-git-send-email-l.krishna@samsung.com>
 <CAH9JG2X_3iUTiGWv2cxjiX-s_VUtptVbzxhAJTub70W_2Dxecg@mail.gmail.com>
 <CAAQKjZNmizjZ-=JN9_AysPMPHTOh7eydfE_OCYE6-v0JAJMydw@mail.gmail.com>
 <5048837B.6020903@samsung.com>
Message-ID: <CAL1wa8cyhxCObHbMa+8X6DmsD8svt=W8s+JMrPx5cAEoWd4Lig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 6, 2012 at 4:35 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> Hi,
>
> On 09/06/2012 09:21 AM, InKi Dae wrote:
>>>> +Required properties:
>>>> + - compatible: Should be "samsung,exynos5-fimd" or "samsung,exynos4-fb" for
>>> Doesn't better to use single word? fimd or fb?. I think 'fb' is used
>>> for framebuffer historically.
>>> but now it's used both fb and drm, so fimd is neutral and architecture
>>> specific.
>>>
>>> To do this, Modify arch-exynos first and update it at each drivers it properly.
>>>
>>> Thank you,
>>> Kyungmin Park
>>>
>>
>> I agree with Kyungmin but I'd like to use as is. the reason we used
>> 'exynos4-fb' as device name, is for that it uses fimd driver's
>> platform device commonly and gets fimd clock. so I think that dts file
>> should be defined with hardware specific name but not driver name such
>> as 'exynos4-fb'. but with this, we can't get fimd clock with device's
>> name because 'exynos4-fb' is used as device name of fimd clock. so to
>> use 'exynos4-fimd', we should modify the device name of fimd clock
>> from 'exynos4-fb'  to 'exynos4-fimd' and also ids definitions of
>> s3c-fb and drm fimd driver. so my conclusion is that it merges this
>
> I think it's good moment to put those things in order, i.e. use uniform
> 'compatible' names: "samsung,exynos4-fimd", "samsung,exynos5-fimd".
> Platform device names are separate issue, but could perhaps be unified
> at this time as well.

Yes, Platform device name is independent of compatible string.
Will change the compatible string to "samsung,exynos4-fimd" and will keep the
device name as exynos4-fb for now. Will change the platform device
names to exynosX-fimd
later.

>
>> patch set as is and then let's modify related things later.
>> any opinions, welcome~ anytime.
>>
>> Thanks.
>> Inki Dae
>
> --
>
> Regards,
> Sylwester
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
