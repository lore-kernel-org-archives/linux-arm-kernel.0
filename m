From: ivan.ivanov@linaro.org (Ivan T. Ivanov)
Date: Fri, 8 May 2015 20:57:49 +0300
Subject: [PATCH v2 2/2] arm64: dts: qcom: Add msm8916 CoreSight components
In-Reply-To: <CANLsYkxFzQPCWXb0w8BddtuJB_cXUtUHBTapYFDF9zqhDBQHrw@mail.gmail.com>
References: <1431012969-16338-1-git-send-email-ivan.ivanov@linaro.org>
 <1431012969-16338-3-git-send-email-ivan.ivanov@linaro.org>
 <CANLsYkzNXBH0d6v1Ny_JwpW6NcKr9v0oAi9K3YfipwDgHWfMMA@mail.gmail.com>
 <1431092877.21307.18.camel@linaro.org>
 <CANLsYkyNYQf80c+8uMbZDr=kQ2YEOqy2aS8muEJsLsanDRGLOQ@mail.gmail.com>
 <1431094640.21307.23.camel@linaro.org>
 <CANLsYkxFzQPCWXb0w8BddtuJB_cXUtUHBTapYFDF9zqhDBQHrw@mail.gmail.com>
Message-ID: <7DD9F545-FA01-427B-BB6E-9A54F1DFF94E@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On May 8, 2015, at 7:17 PM, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
> 
> On 8 May 2015 at 08:17, Ivan T. Ivanov <ivan.ivanov@linaro.org> wrote:
>> 
>> On Fri, 2015-05-08 at 08:13 -0600, Mathieu Poirier wrote:
>>> On 8 May 2015 at 07:47, Ivan T. Ivanov ivanov at linaro.org> wrote:
>>>> On Fri, 2015-05-08 at 07:38 -0600, Mathieu Poirier wrote:
>>>>> On 7 May 2015 at 09:36, Ivan T. Ivanov ivanov at linaro.org> wrote:
>>>>>> Add initial set of CoreSight components found on Qualcomm's 8x16 chipset.
>>>>>> 
>>>>>> 
>>>>>> +       replicator at 824000 {
>>>>>> +               compatible = "qcom,coresight-replicator", "arm,primecell";
>>>>> 
>>>>> Shouldn't it be "qcom,coresight-replicator1x" ?
>>>>> 
>>>> 
>>>> 
>>>> 
>>>> True, I still wonder, why we have to have this compatible string?
>>>> Drivers are probed by amba_id and "arm,primecell", after all.
>>>> 
>>> 
>>> Drivers have their own compatible strings for historical reasons,
>>> something I've been meaning to fix for a long time now...
>>> 
>> 
>> Yep, I see that they have been platform drivers in the past, but now
>> they are not, except coresight-replicator driver. IMHO, having
>> additional compatible string could lead just to confusion.
> 
> I did a little more research on this and based on what I found in the
> kernel it may not need "fixing" after all.  The majority of drivers
> that do specify "arm,primecell" also specify a device-specific
> compatible string.  And in the case of CoreSight devices were
> implementers can do pretty much whatever they  want with the ID
> strings, it is only a matter of time before we need to call something
> like of_device_is_compatible() to fix a quirk.
> 
> Unless someone heavy asks to remove the device-specific compatible
> strings I'd prefer keeping the current trend set forth by other
> drivers and as such, will ask you to add the "1x" in this bindings.


Well, I don?t strongly object against this ?1x?, I will add it. 
My point is that if we can dynamically detect device version, 
which we can do in this case, it will be more robust to do it
in this way. 

If there are not issues with patch 1/2, I will like to fix and 
resend only this patch.

Regards,
Ivan

  
