From: skannan@codeaurora.org (Saravana Kannan)
Date: Fri, 23 Feb 2018 13:46:50 -0800
Subject: [PATCH v11 8/8] perf: ARM DynamIQ Shared Unit PMU support
In-Reply-To: <20180223113552.2gn27h4uxbpo5zoq@lakrids.cambridge.arm.com>
References: <20180102112533.13640-1-suzuki.poulose@arm.com>
 <20180102112533.13640-9-suzuki.poulose@arm.com>
 <5A8E2BCE.3050509@codeaurora.org>
 <20180222113352.oeedj7upx3zxvdcc@lakrids.cambridge.arm.com>
 <5A8F2A4F.5020105@codeaurora.org>
 <20180223113552.2gn27h4uxbpo5zoq@lakrids.cambridge.arm.com>
Message-ID: <5A908BCA.3080403@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/23/2018 03:35 AM, Mark Rutland wrote:
> On Thu, Feb 22, 2018 at 12:38:39PM -0800, Saravana Kannan wrote:
>> On 02/22/2018 03:33 AM, Mark Rutland wrote:
>>> On Wed, Feb 21, 2018 at 06:32:46PM -0800, Saravana Kannan wrote:
>>>> I'm not exactly sure if we can add entries to perf_type_id. If that's
>>>> allowed maybe we need to add something line PERF_TYPE_DSU and use that?
>>>>
>>>> Or if that's not allowed then would it be better to offset the DSU PMU
>>>> events by some number (say 0x1000) and then delete the event type check or
>>>> pass PERF_TYPE_RAW to perf_pmu_register()?
>>>
>>> As above, neither of these should be necessary.
>>
>> For the userspace interface. How about the kernel interface though?
>> perf_event_create_kernel_counter() takes attr.type as an input. But there's
>> no way to look up the DSU PMU's "type".
>
> There is no lookup mechanism currently.
>
> I take it you want to use DSU events from a kernel module?

Yes

>
> It would be possible to have a simlar name -> type lookup mechanism
> kernel-side, if necessary.

Yeah, this is what I was thinking once you explained how user space 
handles this. Just wanted to hear it from this thread. I can submit a patch.

Thanks,
Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
