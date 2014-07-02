From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 02 Jul 2014 13:27:55 +0900
Subject: [PATCH] ARM: dts: Add TMU dt node to monitor the temperature for
 Exynos3250
In-Reply-To: <CAK5sBcHrMPweMSxfde0SSDOtRHbf7t7WQZkf0wAZNTc+N2=Wgg@mail.gmail.com>
References: <1404175210-9278-1-git-send-email-cw00.choi@samsung.com>
 <CAK5sBcFJMK-y+MZPXCufKEmp=v1nFJHstvNTczsQ3ez3SUPbKw@mail.gmail.com>
 <53B23362.7080103@samsung.com>
 <CAK5sBcER-rFmqe74b8uS=ZxKnTNGtkE0x6f7zaLphmyuHJz7Yg@mail.gmail.com>
 <53B349AF.4080606@samsung.com>
 <CAK5sBcHrMPweMSxfde0SSDOtRHbf7t7WQZkf0wAZNTc+N2=Wgg@mail.gmail.com>
Message-ID: <53B38A4B.4020407@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sachin,

On 07/02/2014 12:09 PM, Sachin Kamat wrote:
> On Wed, Jul 2, 2014 at 5:22 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> On 07/01/2014 01:10 PM, Sachin Kamat wrote:
>>> Hi Chanwoo,
>>>
>>> On Tue, Jul 1, 2014 at 9:34 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>>> Hi Sachin,
>>>>
>>>> On 07/01/2014 12:33 PM, Sachin Kamat wrote:
>>>>> Hi Chanwoo,
>>>>>
>>>>> On Tue, Jul 1, 2014 at 6:10 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>>>>> This patch add TMU (Thermal Management Unit) dt node to monitor the high
>>>>>> temperature for Exynos3250.
>>>>>>
>>>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>>>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>>>>>> ---
>>>>>> This patch has a dependency on following patch [1]:
>>>>>>  [1] https://lkml.org/lkml/2014/6/30/805
>>>>>>
>>>>>>  arch/arm/boot/dts/exynos3250.dtsi | 10 ++++++++++
>>>>>>  1 file changed, 10 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
>>>>>> index 3660cab..1e566af 100644
>>>>>> --- a/arch/arm/boot/dts/exynos3250.dtsi
>>>>>> +++ b/arch/arm/boot/dts/exynos3250.dtsi
>>>>>> @@ -192,6 +192,16 @@
>>>>>>                         status = "disabled";
>>>>>>                 };
>>>>>>
>>>>>> +               tmu: tmu at 100C0000 {
>>>>>> +                       compatible = "samsung,exynos3250-tmu";
>>>>>> +                       interrupt-parent = <&gic>;
>>>>>> +                       reg = <0x100C0000 0x100>;
>>>>>> +                       interrupts = <0 216 0>;
>>>>>> +                       clocks = <&cmu CLK_TMU_APBIF>;
>>>>>> +                       clock-names = "tmu_apbif";
>>>>>> +                       status = "disabled";
>>>>>
>>>>> I don't think there would be any board specific properties needed. Hence
>>>>> leave the status as enabled (by deleting the above line).
>>>>>
>>>>
>>>> I think that if specific board need TMU feature, dts file for specific board
>>>> should include tmu dt node with 'okay' status. The specific board based on
>>>> Exynos3250 might not need TMU feature.
>>>
>>> The status field in DT node is not meant for stating the build configuration but
>>> represents the readiness of the hardware for usage on the platform. If
>>> a particular
>>> board does not need this feature it needs to be disabled in the build
>>> config and only
>>> for any special requirements disable it in board file.
>>
>> TMU (Thermal Management Unit) needs specific regulator for TMU power as following:
>> The regulator for TMU is dependent on board.
> 
> In this case it makes sense to leave it disabled in dtsi.
> 

Thanks for your review.

Best Regards,
Chanwoo Choi
