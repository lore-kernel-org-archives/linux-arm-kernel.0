From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 12 Apr 2017 11:18:21 +0100
Subject: [GIT PULL] arm64: fixes for -rc6
In-Reply-To: <20170412091445.GB27097@arm.com>
References: <20170407160239.GS19342@arm.com>
 <3b32cfd3-7675-005b-a737-58a8677f65ac@redhat.com>
 <20170412091445.GB27097@arm.com>
Message-ID: <92306b33-f41e-476a-2ba4-f41da0dc6576@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/04/17 10:14, Will Deacon wrote:
> Hi Jon,
>
> On Tue, Apr 11, 2017 at 03:12:57PM -0400, Jon Masters wrote:
>> On 04/07/2017 12:02 PM, Will Deacon wrote:
>>
>>> Please pull these two arm64 fixes for -rc6. We've got a regression fix for
>>> the signal raised when userspace makes an unsupported unaligned access and a
>>> revert of the contiguous (hugepte) support for hugetlb, which has once again
>>> been found to be broken. One day, maybe, we'll get it right.
>>
>> <snip>
>>
>>> - Revert broken support for the contiguous bit in hugetlb (again...)
>>
>> Quick aside: is this being worked on for 4.12? If not, should we ping
>> Linaro and look to get some focus on this? It's right to disable this,
>> but also painful to those wanting to work on various NFV use cases.
>
> I think Punit and Steve (CC'd) are working on this, but the issues run
> beyond the lack of break-before-make. The core GUP code, for example,
> doesn't even support hugeptes. There are also dormant issues with hugeptes
> and swap/migration entries, which would hit if somebody flipped
> CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION. Hell, even the pte_huge macro is
> bogus if you're using contiguous ptes (granted, it's seldom used, but if
> the above are fixed maybe it will be).

Steve has a fix for the break-before-make[0].

I've posted some fixes for contiguous hugepages support in preparation
for enabling memory failure handling[1] but as the changes touch
multiple architectures, it may take some time to merge.

I'll take a look at the GUP code next but no promises on a timeframe yet.

Thanks,
Punit

[0]
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/497027.html
[1] https://lwn.net/Articles/718974/
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
