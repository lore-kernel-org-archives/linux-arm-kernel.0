From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 03 Mar 2017 10:17:28 +0000
Subject: [PATCH/RFC] arm64: pmu: add Qualcomm Technologies extensions
In-Reply-To: <2c6fcb54-482a-14dc-0fbb-58df0f9a68b5@codeaurora.org> (Neil
 Leeder's message of "Thu, 2 Mar 2017 14:30:53 -0500")
References: <1488385085-19238-1-git-send-email-nleeder@codeaurora.org>
 <20170301181032.GL28874@leverpostej>
 <a44d89fa-c5ff-9511-c774-59e5a3f26676@codeaurora.org>
 <4b90b76f-f08d-f248-8153-287b2552dceb@arm.com>
 <2c6fcb54-482a-14dc-0fbb-58df0f9a68b5@codeaurora.org>
Message-ID: <8737eu4qbr.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 02 2017 at  7:30:53 pm GMT, "Leeder, Neil" <nleeder@codeaurora.org> wrote:
> Hi Mark Z.,
>
> On 3/2/2017 4:05 AM, Marc Zyngier wrote:
>> On 01/03/17 21:36, Leeder, Neil wrote:
>>> On 3/1/2017 1:10 PM, Mark Rutland wrote:
>>>> KVM already has (architected) PMU support, and without a corresponding
>>>> KVM patch this is at best insufficient. I don't imagine the KVM folk
>>>> will be too thrilled about the prospect of emulating an IMPLEMENTATION
>>>> DEFINED CPU feature like this.
>>>
>>> Does KVM handle ARMv7 PMU implementations? If so, do you know what it
>>> does for the scorpion_* and krait_* implementations in
>>> arch/arm/kernel/perf_events_v7.c? These extensions in ARMv8 are very
>>> similar to the krait extensions, with some 64-bit tweaks, so could be
>>> handled by KVM the same way it handles the ARMv7 cases.
>>
>> No, KVM doesn't handle the ARMv7 PMU at all. I'm not aware of the
>> virtualization extensions being available on Scorpion or Krait, which
>> makes it a moot point. What it handles is the PMUv3 architecture.
>
> Thank you for the explanation.
>
> This driver is specifically for Qualcomm Technologies server
> chips. They will not be in a heterogenous environment with
> non-Qualcomm processors, so there should be no migration issues.

How do you know that? I'm afraid this is not something you or I can
guarantee (and even less enforce).

> If we were to provide a patch which added KVM support for the 4
> additional registers here, would you consider reviewing it, or is
> adding implementation-defined registers a show-stopper?

At the moment, it seems that there is a consensus against adding support
for an IMPDEF PMU.

Thanks,

	M.
-- 
Jazz is not dead, it just smell funny.
