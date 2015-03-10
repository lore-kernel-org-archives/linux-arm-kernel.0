From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 10 Mar 2015 13:10:08 -0500
Subject: [PATCH v2 1/3] devicetree: bindings: Document qcom,
 msm-id and qcom, board-id
In-Reply-To: <CAOesGMjJXyjNH-Lm66mZXq0X=52DyRtdmpvQ4sFEr0cMAp3b-w@mail.gmail.com>
References: <1425503602-24916-1-git-send-email-galak@codeaurora.org>
 <CAOesGMjpOx4SxY7j8jnoEwLG+mhPKB2st8qCb-hduHLOVw=RcQ@mail.gmail.com>
 <F9B276F7-61EF-4406-AB46-97D7F1ECEEFE@codeaurora.org>
 <89746055.qtEO3GZJmR@wuerfel>
 <F5017A7F-0EA2-41B3-A9DD-6123CCFD36FA@codeaurora.org>
 <CAOesGMjJXyjNH-Lm66mZXq0X=52DyRtdmpvQ4sFEr0cMAp3b-w@mail.gmail.com>
Message-ID: <3A588B25-66ED-4BB5-8C8F-D050D8A2F9F3@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>>>>>> The top level qcom,msm-id and qcom,board-id are utilized by bootloaders
>>>>>>>>>> on Qualcomm MSM platforms to determine which device tree should be
>>>>>>>>>> utilized and passed to the kernel.
>>>>>>>>>> 
>>>>>>>>>> Cc: <devicetree@vger.kernel.org>
>>>>>>>>>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
>>>>>>>>> 
>>>>>>>>> Is this the special magic that allows qcom bootloaders to take a kernel
>>>>>>>>> plus multiple DTBs and figure out which DTB to pass?
>>>>>>>>> 
>>>>>>>>> Kevin
>>>>>>>> 
>>>>>>>> yes
>>>>>>> 
>>>>>>> That's a bummer.
>>>>>>> 
>>>>>>> Luckily, the solution for upstream is still quite simple: Provide only
>>>>>>> one devicetree, and it'll be used, right?
>>>>>> 
>>>>>> We can provide only one, we still need the IDs in the DT.
>>>>> 
>>>>> How are the DTS provided? Concatenated with the kernel, or in a
>>>>> wrapped data format? Or in a separate partition from the kernel?
>>>> 
>>>> Its a wrapped data format that is than concatenated with the kernel if I remember correctly.
>>> 
>>> Then you should be able to create a tool that can write this concatenated
>>> format and insert these properties from a table that matches the boot
>>> loader, right?
>>> 
>>>      Arnd
>> 
>> Are you suggesting the tool insert the properties in the DT?  I?m not sure I understand what the point of doing that would be.
> 
> To insert platform-local properties that mean nothing outside of the
> firmware packaging of the device trees, which is the case here?
> 
> I think the idea of having the installer script inserting them is
> quite reasonable in this case.
> 
> 
> -Olof

These values are static, so not sure what the point of having the installer script do that?

- k

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
