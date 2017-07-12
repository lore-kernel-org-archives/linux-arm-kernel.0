From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 12 Jul 2017 08:15:43 -0400
Subject: [PATCH V4] PCI: Add Extended Tags quirk for Broadcom HT2100 Root
 Port
In-Reply-To: <CABawtvMCJy1Y0Cv-NhVRv4qKLiZ-PUWfeZhTA6uGiiiswe+g6A@mail.gmail.com>
References: <1499832255-9845-1-git-send-email-okaya@codeaurora.org>
 <20170712105550.6007fa06.wim.ten.have@oracle.com>
 <CABawtvMCJy1Y0Cv-NhVRv4qKLiZ-PUWfeZhTA6uGiiiswe+g6A@mail.gmail.com>
Message-ID: <b8ccaffe-d907-db04-a793-86a3b67f61af@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7/12/2017 5:44 AM, Ethan Zhao wrote:
> The dmesg yelled "...Tag handling is broken" , but didn't say how it
> was handled, that is weird and confusing, just because there is no
> device under that bridge ?
> 
> How about move the messages together "...is broken, disable Extended tag..."

This was something requested by Bjorn to inform that user has a broken HW
when a quirk is matched.

The new code will disable extended tags only if it was enabled on endpoint
via power on reset value or via some broken BIOS.

It looks like we are not seeing any disabling message. This implies that
both the card and BIOS is good.

That's why, you are no longer seeing a disabling message on this system
and code is just not enabling extended tags.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
