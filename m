From: awallis@codeaurora.org (Adam Wallis)
Date: Mon, 4 Dec 2017 10:48:45 -0500
Subject: [PATCH v4] usb: xhci: allow imod-interval to be configurable
In-Reply-To: <9cb2e5fc-1bec-c19c-c04e-fe56e5c1bc16@codeaurora.org>
References: <1512397671-28733-1-git-send-email-awallis@codeaurora.org>
 <9cb2e5fc-1bec-c19c-c04e-fe56e5c1bc16@codeaurora.org>
Message-ID: <2b252975-bf1f-7468-071e-f4a4aa2430a0@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Timur

On 12/4/2017 9:58 AM, Timur Tabi wrote:
> On 12/4/17 8:27 AM, Adam Wallis wrote:
>> If no interval is specified, the default of 40,000ns (IMOD=160) will be
>> used.
> 
> ...
> 
>> + - imod-interval-ns: default interrupt moderation interval is 5000ns
> 
> ...
> 
>> +? - imod-interval-ns: default interrupt moderation interval is 5000ns
> 
> ...
> 
>> +??? xhci->imod_interval = 5000;
> 
> ...
> 
>> +??? xhci->imod_interval = 40000;
> 
> ...
> 
>> +??? xhci->imod_interval = 40000;
> 
> Is the default 5,000 or 40,000?? I can't tell.
> 
As noted in the patch description, xhci-plat devices will use a default of
40,000, while MTK devices will use a default of 5,000. This is also documented
in the probe for each relevant driver. This is further confirmed in the
description for each driver's binding TXT file.

Adam

-- 
Adam Wallis
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
