From: punnaiah.choudary.kalluri@xilinx.com (Punnaiah Choudary Kalluri)
Date: Mon, 7 Apr 2014 15:52:08 +0000
Subject: [PATCH 00/75] l2c series
In-Reply-To: <53426BE8.5090405@monstr.eu>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <533D7672.4090003@monstr.eu> <20140403193328.GY7528@n2100.arm.linux.org.uk>
 <533E5B71.20406@monstr.eu> <20140404192824.GG7528@n2100.arm.linux.org.uk>
 <5342440E.2020301@monstr.eu> <20140407090002.GU7528@n2100.arm.linux.org.uk>
 <53426BE8.5090405@monstr.eu>
Message-ID: <1bd898f9-5fb8-4d9a-968c-711b607eb961@VA3EHSMHS031.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



>On 04/07/2014 11:00 AM, Russell King - ARM Linux wrote:
>> On Mon, Apr 07, 2014 at 08:22:06AM +0200, Michal Simek wrote:
>>> On 04/04/2014 09:28 PM, Russell King - ARM Linux wrote:
>>>> On Fri, Apr 04, 2014 at 09:12:49AM +0200, Michal Simek wrote:
>>>>> On 04/03/2014 09:33 PM, Russell King - ARM Linux wrote:
>>>>>> On Thu, Apr 03, 2014 at 04:55:46PM +0200, Michal Simek wrote:
>>>>>>> Hi Russell,
>>>>>>>
>>>>>>> On 03/28/2014 04:12 PM, Russell King - ARM Linux wrote:
>>>>>>>> This is another posting of the L2 cache controller series.  I'm not
>>>>>>>> planning for this for the upcoming merge window, but the one after,
>>>>>>>> as people need to test it and still need to feed back to me on
>>>>>>>> various issues.  Hence, this is not a finalised series.
>>>>>>>>
>>>> - a driver coupled to the arm,pl310-cache compatible for this which is
>>>>   distinctly separate from the main "driver" is probably a bad idea.
>>>>   what if we want our existing l2 stuff to couple into the driver model
>>>>   to expose some properties at a later date (eg, maybe to deal with
>>>>   stuff like the power management settings?)  For example, it may be
>>>>   that we want to expose the prefetch offset so that people can easily
>>>>   play with the value to determine the correct tuning for their workload.
>>>
>>> We choose that name for starting to discuss this how to do it better.
>>> We could use zynq-edac-l2 or zynq-edac-r3p2, etc version.
>>
>> I'm not talking about the compatible name.  I'm certainly not suggesting
>> that you should describe the L2 as two separate devices in DT.  I'm saying
>> that this should appear as one _single_ driver for the entire device.
>
>great.
>
It means there are two drivers, one for l2 cache edac and one for l2 cache configuration
 and management in a single file. Please correct me if I am wrong.

Thanks.
Punnaiah


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
