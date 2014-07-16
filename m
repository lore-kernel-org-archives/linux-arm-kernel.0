From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Wed, 16 Jul 2014 23:23:42 +0900
Subject: [PATCH v6 2/7] arm64: Introduce VA_BITS and translation level
 options
In-Reply-To: <95F7642B-124A-4E03-ACDE-5BF9D70E8E15@arm.com>
References: <000101cf6dc6$3b93d510$b2bb7f30$@samsung.com>
 <CAOZdJXWCu-zHuQoAUdiieqsKqCfG9BsZariFqQP=NCgQP-zpNA@mail.gmail.com>
 <53C43FE3.1050008@amd.com> <20140714224159.GA9829@arm.com>
 <3AF98E68-6818-416A-BC33-57148F1EC246@gmail.com>
 <95F7642B-124A-4E03-ACDE-5BF9D70E8E15@arm.com>
Message-ID: <6986494B-04F6-45F0-9C39-303D1F5992D3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Jul 16, 2014, at 6:44 AM, Catalin Marinas wrote:
> On 15 Jul 2014, at 15:53, Jungseok Lee <jungseoklee85@gmail.com> wrote:
>> On Jul 15, 2014, at 7:41 AM, Catalin Marinas wrote:
>>> On Mon, Jul 14, 2014 at 09:38:59PM +0100, Joel Schopp wrote:
>>>> I agree that these patches would be very useful.  I just rebased my fix
>>>> for a VTTBR_BADDR_MASK bug on one of these patches that could be pulled
>>>> out independently.  See
>>>> https://lists.cs.columbia.edu/pipermail/kvmarm/2014-July/010480.html
>>>> 
>>>> The original author Jungseok Lee is no longer available to work on
>>>> future versions of these patches.  I was thinking that if they didn't
>>>> get picked up as they are that with the original author's blessing I
>>>> would pick them up and keep them forward ported/resubmitted.  I have an
>>>> SOC to test them on.
>>> 
>>> The patches are pretty good. I'll give them a try tomorrow and if there
>>> isn't something fundamental missing I'll consider taking them for 3.17.
>> 
>> Hi All,
>> 
>> If only stage1 side is taken and merged, KVM should be disabled under 4 level
>> lookups with the following configuration adjustment. I've tested it on top of
>> arm64/for-next/core branch and it works fine.
>> 
>> --- a/arch/arm64/kvm/Kconfig
>> +++ b/arch/arm64/kvm/Kconfig
>> @@ -18,6 +18,7 @@ if VIRTUALIZATION
>> 
>> config KVM
>>       bool "Kernel-based Virtual Machine (KVM) support"
>> +       depends on !ARM64_4_LEVELS
>>       select MMU_NOTIFIER
>>       select PREEMPT_NOTIFIERS
>>       select ANON_INODES
>> 
>> However, I don't know whether it does make sense or not.
> 
> I added some patches on top of your series, I hope to be able to post
> them tomorrow. My interim approach was to disable 4-levels if KVM is
> enabled.

Hi Catalin,

Thanks for the work!
I will take a close look at them.

- Jungseok Lee
