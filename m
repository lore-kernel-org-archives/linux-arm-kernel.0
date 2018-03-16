From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 16 Mar 2018 12:33:14 -0400
Subject: [Intel-wired-lan] [PATCH v3 09/18] fm10k: Eliminate duplicate
 barriers on weakly-ordered archs
In-Reply-To: <CAKgT0UcKdCpzFgX4qn7EdYnedOsJa9as5g24tfb6qFLXTxZ29A@mail.gmail.com>
References: <1521216991-28706-1-git-send-email-okaya@codeaurora.org>
 <1521216991-28706-10-git-send-email-okaya@codeaurora.org>
 <CAKgT0UcKdCpzFgX4qn7EdYnedOsJa9as5g24tfb6qFLXTxZ29A@mail.gmail.com>
Message-ID: <2d346b70-70d4-5996-24ce-94031ee68c90@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/16/2018 12:30 PM, Alexander Duyck wrote:
> On Fri, Mar 16, 2018 at 9:16 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> Code includes wmb() followed by writel(). writel() already has a
>> barrier on some architectures like arm64.
>>
>> This ends up CPU observing two barriers back to back before executing
>> the register write.
>>
>> Since code already has an explicit barrier call, changing writel() to
>> writel_relaxed().
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> 
> You can update the writel call in fm10k_tx_map as well.
> 
> Of the drivers updated in drivers/net/ethernet/intel/* it looks like
> this is the only one that still requires any additional changes.

will do. thanks for the feedback.

> 
> Thanks.
> 
> - Alex
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
