From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Wed, 19 Nov 2014 10:19:40 +0530
Subject: [[PATCHv2] 3/3] drivers/rtc/rtc-snvs: Add clock support
In-Reply-To: <20141119011721.GA24042@dragon>
References: <cover.1415364391.git.maitysanchayan@gmail.com>
 <30e496ce2d6521e608df3b68b73b3e05caa1daef.1415364391.git.maitysanchayan@gmail.com>
 <7807253ec0fd349b5bb1489e0d3b1347@agner.ch> <546320D3.2030501@gmail.com>
 <20141112104735.GK2704@dragon> <54644295.2050003@gmail.com>
 <20141119011721.GA24042@dragon>
Message-ID: <546C2164.3040708@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 November 2014 06:47 AM, Shawn Guo wrote:
> On Thu, Nov 13, 2014 at 11:03:09AM +0530, Sanchayan Maity wrote:
>> On Wednesday 12 November 2014 04:17 PM, Shawn Guo wrote:
>>> On Wed, Nov 12, 2014 at 02:26:51PM +0530, Sanchayan Maity wrote:
>>>> On Wednesday 12 November 2014 02:57 AM, Stefan Agner wrote:
>>>>> On 2014-11-07 14:04, Sanchayan Maity wrote:
>>>>>> This patch adds clock enable and disable support for
>>>>>> the SNVS peripheral, which is required for using the
>>>>>> RTC within the SNVS block.
>>>>>
>>>>> What happens if the device tree node is there while this patch is not
>>>>> applied? I guess the driver would load, but since the clocks of the
>>>>> peripheral are not enabled the first register access would lead to bus
>>>>> error or similar. If this is the case, this would break bisectability.
>>>>> You should move the device tree patch to the end.
>>>>>
>>>>
>>>> If the DT node was present with this patch not applied, the driver would 
>>>> still crash with a bus error, since the clocks for SNVS are not explicitly 
>>>> enabled anywhere else. I had not thought about any problems which might 
>>>> occur later with git bisect. Will move this to the end with v3.
>>>
>>> Since changes on rtc-snvs.c will need to go through RTC subsystem tree,
>>> that means I cannot apply DTS changes until the driver patch gets
>>> mainlined and appears on my tree.
>>>
>>> Shawn
>>
>> Shawn
>>
>> So the approach in this patch is OK and acceptable? 
> 
> Yes, I'm fine with it.
> 
> Shawn


Hello Alessandro, 

Sorry I missed adding you while sending this patch set.

Can you take this third patch, in this series through your RTC subsytem
tree? Or should I resend this third patch separately?

Regards,
Sanchayan.

> 
>>
>> Since the DT changes cannot be applied by you, till this goes through the 
>> RTC subsystem tree, gets mainlined and appears on your tree, I will send out 
>> this patch by itself then and send the DT changes later once this gets
>> mainlined?
>>
>> I did not CC Alessandro Zummo, the maintainer of RTC subsystem by mistake.
>> Once you ACK/OK this i will send out this patch in isolation then or just 
>> CC Alessandro Zummo.
