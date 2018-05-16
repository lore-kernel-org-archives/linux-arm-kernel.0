From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 16 May 2018 14:41:12 -0400
Subject: [RFC PATCH] efi/fb: Convert PCI bus address to resource if
 translated by the bridge
In-Reply-To: <3120434b-9831-bf33-25b8-11aba1c1b648@codeaurora.org>
References: <1526495029-25783-1-git-send-email-okaya@codeaurora.org>
 <3120434b-9831-bf33-25b8-11aba1c1b648@codeaurora.org>
Message-ID: <9f8ea8f6-6005-1b46-4d75-4f89e04ad9c1@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/16/2018 2:31 PM, Timur Tabi wrote:
> On 05/16/2018 01:23 PM, Sinan Kaya wrote:
>> +??????? win_start = window->res->start - window->offset;
> 
> Can you guarantee that window->res->start is always >= window->offset?
> 

Resource offset is generally 0 when not translating or a positive number
that you subtract from the resource start to reach to the translating window.

Having a bigger offset than resource start should be considered a BIOS bug.

>> +??????? win_size = window->res->end - window->res->start + 1;
> 
> Use resource_size() instead.
> 

I'll fix it.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
