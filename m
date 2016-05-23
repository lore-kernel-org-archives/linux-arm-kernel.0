From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 23 May 2016 18:26:25 -0400
Subject: [PATCH] soc: qcom: provide mechanism for drivers to access L2
 registers
In-Reply-To: <f49d58ed-38b4-6284-11c2-8708d8443b14@codeaurora.org>
References: <1463771587-7438-1-git-send-email-nleeder@codeaurora.org>
 <20160523172527.GK4976@leverpostej>
 <f49d58ed-38b4-6284-11c2-8708d8443b14@codeaurora.org>
Message-ID: <57438391.7090405@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/23/2016 02:22 PM, Neil Leeder wrote:
> 
> On 5/23/2016 01:25 PM, Mark Rutland wrote:
>> On Fri, May 20, 2016 at 03:13:07PM -0400, Neil Leeder wrote:
>>> L2 registers are accessed using a select register and data
>>> register pair. To prevent multiple concurrent writes to the
>>> select register by independent drivers, the write to the
>>> select register and the associated access of the data register
>>> are protected with a lock. All drivers accessing the L2
>>> registers use the set and get functions provided by
>>> l2-accessors to ensure correct reads and writes to L2 registers.
>>
>> What will this be used for? (i.e. which drivers want to touch the L2
>> registers?).
>>
>> Generally we expect FW to configure the caches and interconnect
>> appropriately.
> 
> The primary use is in the L2 PMU driver, which will be posted shortly.
> 
>>
>>> Signed-off-by: Neil Leeder <nleeder@codeaurora.org>
>>> ---
>>>  drivers/soc/qcom/Kconfig              |  9 +++++
>>>  drivers/soc/qcom/Makefile             |  1 +
>>>  drivers/soc/qcom/l2-accessors.c       | 66 +++++++++++++++++++++++++++++++++++
>>>  include/linux/soc/qcom/l2-accessors.h | 27 ++++++++++++++
>>>  4 files changed, 103 insertions(+)
>>>  create mode 100644 drivers/soc/qcom/l2-accessors.c
>>>  create mode 100644 include/linux/soc/qcom/l2-accessors.h
>>
>> These are awfully generic file names (and function names). Which SoCs
>> does this apply to?
>>
>> It would be good to give these more specific names.
> 
> It's under soc/qcom, and dependent on ARCH_QCOM and (in v2) also on ARM64. It applies to all QCOM ARM64 SoCs.
> Given that it can only be used in a QCOM driver, and the include path has qcom in it, I'd
> prefer not to add redundancy by adding another qcom in there.

They ended up calling the pinctrl file qcom/pinctrl/qdf2xxx.c.

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=8f1338cd80648adf5434798f5393ad7c55d10848

Regards,
Cov

-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
