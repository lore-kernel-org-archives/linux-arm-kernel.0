From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Mon, 29 Aug 2016 10:35:58 -0500
Subject: [PATCH] irqchip/gicv3-its: Enable cacheable attribute
 Read-allocate hints
In-Reply-To: <5784F188.3010609@codeaurora.org>
References: <1468294608-30619-1-git-send-email-shankerd@codeaurora.org>
 <5784A5C8.4080103@arm.com> <5784F188.3010609@codeaurora.org>
Message-ID: <11225da6-559e-c1bd-2ba5-a941595d6532@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

Are you planning to push this change? I talked to Qualcomm ITS hw team 
and they told me nice to have this change even though we see a small gain.

Shanker


On 07/12/2016 08:32 AM, Shanker Donthineni wrote:
> Hi Marc,
>
> On 07/12/2016 03:09 AM, Marc Zyngier wrote:
>> Hi Shanker,
>>
>> On 12/07/16 04:36, Shanker Donthineni wrote:
>>> Read-allocation hints are not enabled for both the GIC-ITS and GICR
>>> tables. This forces the hardware to always read the table contents
>>> from an external memory (DDR) which is slow compared to cache memory.
>>> Most of the tables are often read by hardware. So, it's better to
>>> enable Read-allocate hints in addition to Write-allocate hints in
>>> order to improve the GICR_PEND, GICR_PROP, Collection, Device, and
>>> vCPU tables lookup time.
>> While I'm not opposed to such a change, I'd like to see some evidence
>> that this actually makes a difference. Have you measured an improvement
>> on a particular implementation? If so, could you share your benchmarking
>> method so that it could be be measured on others as well?
> I have seen at least 5% performance gain when I was testing direct 
> VLPI feature
> on Qualcomm emulation platforms. On Silicon, this gain is not noticeable.
>
>
>> Thanks,
>>
>>     M.
>

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
