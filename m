From: olof@lixom.net (Olof Johansson)
Date: Tue, 10 Mar 2015 10:55:47 -0700
Subject: [PATCH v2 1/3] devicetree: bindings: Document qcom,
 msm-id and qcom, board-id
In-Reply-To: <F5017A7F-0EA2-41B3-A9DD-6123CCFD36FA@codeaurora.org>
References: <1425503602-24916-1-git-send-email-galak@codeaurora.org>
 <CAOesGMjpOx4SxY7j8jnoEwLG+mhPKB2st8qCb-hduHLOVw=RcQ@mail.gmail.com>
 <F9B276F7-61EF-4406-AB46-97D7F1ECEEFE@codeaurora.org>
 <89746055.qtEO3GZJmR@wuerfel>
 <F5017A7F-0EA2-41B3-A9DD-6123CCFD36FA@codeaurora.org>
Message-ID: <CAOesGMjJXyjNH-Lm66mZXq0X=52DyRtdmpvQ4sFEr0cMAp3b-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 10:13 AM, Kumar Gala <galak@codeaurora.org> wrote:
>
> On Mar 9, 2015, at 7:11 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
>> On Friday 06 March 2015 14:37:52 Kumar Gala wrote:
>>> On Mar 6, 2015, at 1:15 PM, Olof Johansson <olof@lixom.net> wrote:
>>>
>>>> On Fri, Mar 6, 2015 at 8:08 AM, Kumar Gala <galak@codeaurora.org> wrote:
>>>>>
>>>>> On Mar 5, 2015, at 7:59 PM, Olof Johansson <olof@lixom.net> wrote:
>>>>>
>>>>>> On Thu, Mar 5, 2015 at 12:23 PM, Kumar Gala <galak@codeaurora.org> wrote:
>>>>>>>
>>>>>>> On Mar 5, 2015, at 1:42 PM, Kevin Hilman <khilman@kernel.org> wrote:
>>>>>>>
>>>>>>>> Kumar Gala <galak@codeaurora.org> writes:
>>>>>>>>
>>>>>>>>> The top level qcom,msm-id and qcom,board-id are utilized by bootloaders
>>>>>>>>> on Qualcomm MSM platforms to determine which device tree should be
>>>>>>>>> utilized and passed to the kernel.
>>>>>>>>>
>>>>>>>>> Cc: <devicetree@vger.kernel.org>
>>>>>>>>> Signed-off-by: Kumar Gala <galak@codeaurora.org>
>>>>>>>>
>>>>>>>> Is this the special magic that allows qcom bootloaders to take a kernel
>>>>>>>> plus multiple DTBs and figure out which DTB to pass?
>>>>>>>>
>>>>>>>> Kevin
>>>>>>>
>>>>>>> yes
>>>>>>
>>>>>> That's a bummer.
>>>>>>
>>>>>> Luckily, the solution for upstream is still quite simple: Provide only
>>>>>> one devicetree, and it'll be used, right?
>>>>>
>>>>> We can provide only one, we still need the IDs in the DT.
>>>>
>>>> How are the DTS provided? Concatenated with the kernel, or in a
>>>> wrapped data format? Or in a separate partition from the kernel?
>>>
>>> Its a wrapped data format that is than concatenated with the kernel if I remember correctly.
>>
>> Then you should be able to create a tool that can write this concatenated
>> format and insert these properties from a table that matches the boot
>> loader, right?
>>
>>       Arnd
>
> Are you suggesting the tool insert the properties in the DT?  I?m not sure I understand what the point of doing that would be.

To insert platform-local properties that mean nothing outside of the
firmware packaging of the device trees, which is the case here?

I think the idea of having the installer script inserting them is
quite reasonable in this case.


-Olof
