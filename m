From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Mon, 18 Apr 2016 11:14:42 -0500
Subject: [PATCH V6 00/13] Support for generic ACPI based PCI host
 controller
In-Reply-To: <5714FC89.8060005@semihalf.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <CAKc_7PVC6O4oh+bTmpLQRrhHrqGbaKB2hynecKOLmc5fBc-VVQ@mail.gmail.com>
 <5714E224.1030307@semihalf.com> <4253385.YPSgBqNLfg@wuerfel>
 <5714FC89.8060005@semihalf.com>
Message-ID: <571507F2.60005@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/18/2016 10:26 AM, Tomasz Nowicki wrote:
> On 18.04.2016 16:38, Arnd Bergmann wrote:
>> On Monday 18 April 2016 15:33:24 Tomasz Nowicki wrote:
>>>
>>> Of course we can split discussion into the two topics:
>>> 1. ECAM based ACPI host controller - patches [1-10]
>>> 2. Quirks handling and examples.
>>>
>>> IMO, it is very helpful for reviewers to go with one unified patch set
>>> and see the whole picture. Also, as you can see, quirks handling allows
>>> people to test it easily with their servers (not only QEMU but real HW).
>>
>> I think splitting the two would help tremendously. The regular
>> PCI support should just get merged (it should have been completed
>> years ago when ACPI for ARM64 was first implemented), while the quirks
>> handling contains all ugly nonstandard hacks we have to be careful
>> about.
>
> OK, so for those who want to review just "ECAM based ACPI host
> controller" lets consider only patches [1-10]. Patches 11-13 are well
> isolated and do not affect previous one. Is that ok for this series?

As much as I appreciate the idea of splitting the patches and
getting something in sooner rather than later, I'm concerned
because without quirk handling, this code is effectively useless
on 60% or more of available server hardware platforms.

If we're going to split the review into two threads, it can't be
an excuse to drag out the quirk handling for months.

--Mark Langsdorf
