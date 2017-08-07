From: nleeder@codeaurora.org (Leeder, Neil)
Date: Mon, 7 Aug 2017 16:52:02 -0400
Subject: [PATCH 1/2] acpi: arm64: add iort support for PMCG
In-Reply-To: <22df7d0e-3017-b3f6-67e2-21b9ece433c3@arm.com>
References: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
 <1501876754-1064-2-git-send-email-nleeder@codeaurora.org>
 <22df7d0e-3017-b3f6-67e2-21b9ece433c3@arm.com>
Message-ID: <a8cd5d9c-3443-9864-48aa-c9c56d010fad@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,
Thank you for the review.

On 8/7/2017 7:17 AM, Robin Murphy wrote:
> Hi Neil,
> 
> On 04/08/17 20:59, Neil Leeder wrote:
[...]
>> +	res[1].start = pmcg->base_address + SZ_64K;
> 
> Ugh, I see there's a nasty spec hole here - IORT only defines one base
> address, but SMMUv3 says *both* pages have imp-def base addresses. I
> guess this assumption of them being in consecutive 64K regions holds for
> your platform, but as things stand it doesn't appear possible to rely on
> it generally :(
> 
> I'll follow up internally to see if we need to get IORT and/or SBSA
> updated or clarified.
> 
Thanks. I'll wait for the outcome before submitting a new patch.

[...]
>> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
>> index 707dda74..2169b6f 100644
>> --- a/include/acpi/actbl2.h
>> +++ b/include/acpi/actbl2.h
> 
> Hopefully these changes are merely here for reference, but just in case
> it needs to be said, they should go as a separate patch via ACPICA
> (presumably there's also some corresponding iASL stuff to compile PMCG
> nodes in the first place).
> 
Yes, I'll submit this to ACPICA once the IORT addresses get figured out.

Neil
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
