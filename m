From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 3 Jul 2018 09:31:24 -0400
Subject: [PATCH V5 3/3] PCI: Mask and unmask hotplug interrupts during
 reset
In-Reply-To: <2640af5e-f00f-d814-425d-78ac57714f6d@codeaurora.org>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
 <1530571967-19099-4-git-send-email-okaya@codeaurora.org>
 <20180703083447.GA2689@wunner.de>
 <8b6ce0f415858463d1c0588c29e30415@codeaurora.org>
 <9e871cc3978fbdca12ccf8a91f34ad07@codeaurora.org>
 <2640af5e-f00f-d814-425d-78ac57714f6d@codeaurora.org>
Message-ID: <bd04c9d1-6dfe-3071-69f9-beb0d649b6c0@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/3/2018 9:25 AM, Sinan Kaya wrote:
>> what if we only have conditional enumeration ?? (leaving removing devices followed by SBR as is) ?
>>
Sorry, I think I didn't quite get your question. 

Are you asking about the enumeration following link up while keeping the
current code as is?

Issue is observing hotplug link down event in the middle of AER recovery as in
my previous reply.

If we mask hotplug interrupts before secondary bus reset via my patch,
then hotplug driver will not observe both link up and link down interrupts.

If we don't mask hotplug interrupts, we have a race condition.

I hope I answered your question.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
