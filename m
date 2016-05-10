From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 10 May 2016 16:03:07 +0200
Subject: [PATCH] ARM: dts: exynos: Only Odroid XU3-family boards use DTSI
 with CPU thermal nodes
In-Reply-To: <CANAwSgRsjdQh6ygT__5XcH8-cF9Ch+zbk8oupebwYzY1kCZu6g@mail.gmail.com>
References: <1462774789-15360-1-git-send-email-k.kozlowski@samsung.com>
 <CANAwSgT9SY3kj8+beMpc1xGoC=rMBSya+2v2dyZQp6ykH+V0=g@mail.gmail.com>
 <573198BE.6020900@samsung.com>
 <CANAwSgTy6p9AVmmOWATpSO1JqVbwE0v+y_y-RLd+32RnNJTA+Q@mail.gmail.com>
 <5731D764.8070007@samsung.com>
 <CANAwSgRsjdQh6ygT__5XcH8-cF9Ch+zbk8oupebwYzY1kCZu6g@mail.gmail.com>
Message-ID: <5731EA1B.4070201@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/2016 04:00 PM, Anand Moon wrote:
> Hi Krzysztof,
> 
> On 10 May 2016 at 18:13, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
>> On 05/10/2016 11:29 AM, Anand Moon wrote:
>>>>
>>>> I am sorry but I do not understand.
>>>> 1. Are you saying that my patch causes the issue?
>>>> 2. Are you saying that I should not send some patches because of
>>>> conflicting work? (that would be peculiar...)
>>>> 3. Are you saying that I should not apply this patch to me tree because
>>>> of conflicting work?
>>>> 4. Other?
>>>>
>>>> Best regards.
>>>> Krzysztof
>>>>
>>>>
>>>
>>> Sorry for the confusion it's not about you patch.
>>> The feature is not working correctly as per my testing with the
>>> original source code.
>>> It need to be more tuned or some other approach to the issue need to found.
>>
>> Known issue. You don't have cpufreq cooling enabled. I sent patches for
>> that and they are in the mainline. However cpufreq cooling requires
>> cpufreq which cannot work with BL_SWITCHER and on Exynos542x on
>> exynos_defconfig BL_SWITCHER is enabled.
>>
>> Just disable the BL_Krzysztof.
>>
>> Best regards,
>> Krzysztof
> 
> I have already disabled BL_SWITCHER in my exynos_defconfig. to support
> CONFIG_CPUFREQ_DT.
> 
> But how about adjust the  the cputemp so that all the core will have
> same tip points.


I don't understand you. All of the cores have same trip points.

Best regards,
Krzysztof

> 
> xcpu0-t 0:[ 44][>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>     A50
>      A60       P70            P85                                C120
> ]
> xcpu1-t 1:[ 46][>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>                               A85               A103   A110      C120
> ]
> xcpu2-t 2:[ 51][>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>                          A85               A103   A110      C120 ]
> xcpu3-t 3:[ 47][>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>                              A85               A103   A110      C120 ]
> xgpu-th 4:[ 48][>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>                             A85               A103   A110      C120 ]
