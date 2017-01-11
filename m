From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 11 Jan 2017 08:11:08 -0500
Subject: [PATCH v2 2/5] arm64: Work around Falkor erratum 1003
In-Reply-To: <20170104103322.GA20461@cbox>
References: <20161229224335.13531-1-cov@codeaurora.org>
 <20161229224335.13531-2-cov@codeaurora.org> <20170104103322.GA20461@cbox>
Message-ID: <4bd902f7-4900-7ee6-6346-e3f4897afef2@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 01/04/2017 05:33 AM, Christoffer Dall wrote:
> On Thu, Dec 29, 2016 at 05:43:32PM -0500, Christopher Covington wrote:
>> From: Shanker Donthineni <shankerd@codeaurora.org>
>>
>> On the Qualcomm Datacenter Technologies Falkor v1 CPU, memory accesses may
>> allocate TLB entries using an incorrect ASID when TTBRx_EL1 is being
>> updated. Changing the TTBRx_EL1[ASID] and TTBRx_EL1[BADDR] fields
>> separately using a reserved ASID will ensure that there are no TLB entries
>> with incorrect ASID after changing the the ASID.
> 
> When we restore guest state in KVM, we completely save and restore
> TTBRx_EL1 from EL2. Would that be affected by this erratum?

Good question, but apparently not. I'll add the following explanation to the
v3 commit message.

"EL2 and EL3 code changing the EL1&0 ASID is not subject to this erratum
because hardware is prohibited from performing translations from an
out-of-context translation regime."

Thanks,
Cov

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
Aurora Forum, a Linux Foundation Collaborative Project.
