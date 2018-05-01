From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 1 May 2018 18:48:02 -0400
Subject: [PATCH] alpha: io: reorder barriers to guarantee writeX() and
 iowriteX() ordering #2
In-Reply-To: <2fd54f7c-ff73-5935-a253-c924f4373cc6@codeaurora.org>
References: <1523917017-28084-1-git-send-email-okaya@codeaurora.org>
 <b9d845ad-62af-d300-53d9-2b62f5da6c44@codeaurora.org>
 <2fd54f7c-ff73-5935-a253-c924f4373cc6@codeaurora.org>
Message-ID: <ca5f0ecf-bb2b-15ab-1fdd-6a117c223837@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/20/2018 12:20 PM, Sinan Kaya wrote:
> Hi Matt,
> 
> On 4/17/2018 2:43 PM, Sinan Kaya wrote:
>> On 4/16/2018 6:16 PM, Sinan Kaya wrote:
>>> memory-barriers.txt has been updated with the following requirement.
>>>
>>> "When using writel(), a prior wmb() is not needed to guarantee that the
>>> cache coherent memory writes have completed before writing to the MMIO
>>> region."
>>>
>>> Current writeX() and iowriteX() implementations on alpha are not
>>> satisfying this requirement as the barrier is after the register write.
>>>
>>> Move mb() in writeX() and iowriteX() functions to guarantee that HW
>>> observes memory changes before performing register operations.
>>>
>>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
>>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>>  arch/alpha/kernel/io.c | 14 +++++++-------
>>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> Sorry for catching this late but this also needs to go to 4.17 after
>> review.
>>
>> I missed the writel() implementation on arch/alpha/kernel/io.c file
>> on my first patch.
>>
> 
> Can you also queue this for 4.17?
> 
> There are already drivers checked into 4.17 that dropped the unnecessary
> barriers. 
> 
> I really hate to see Alpha broken because of this.

ping.

> 
> Sinan
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
