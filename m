From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 25 Jun 2015 14:02:07 -0700
Subject: [PATCH v2 0/3] ARM: keystone: add ecc error interrupt handling
In-Reply-To: <558C188B.5060107@oracle.com>
References: <1435242710-31346-1-git-send-email-vitalya@ti.com>
 <558C188B.5060107@oracle.com>
Message-ID: <558C6C4F.1090102@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2015 08:04 AM, santosh shilimkar wrote:
> On 6/25/2015 7:31 AM, Vitaly Andrianov wrote:
>> This patch series adds support for arm L1/L2 ecc and ddr3 ecc error
>> handling
>> for Keystone devices
>>
>> Change Log
>>
>> v2:
>> - removing unused and sorting headers of keystone.c are moved to a
>> separate
>>    patch.
>> - l1l2 ecc and ddr3 ecc error handling are split it to separate patches
>> - removed unused headers from keystone_ecc.c
>> - platsmp.c removed from the patch.
>> - return IRQ_HANDLED for 1 bit error in l1l2 ecc handler
>> - checked and handled existing echttps://lwn.net/Articles/593336/c
>> error before enabling ddr3 interrupt
>> - 1 bit ddr3 interrupt is disabled, because it is handled by hardware
>> and
>>    there is no reason to handle it by software
>>
> This version looks good to me. As already commented, I would have liked
> the patch 2/3(L2 ECC) code in ARM generic code so will give some more
> time for others to come back. Otherwise I will queue this up for next
> window.

Why not make this into an edac driver? I sent out an L1/L2 error
detection edac driver for Krait processors a year ago, but it stalled
due to some DT binding stuff[1]. This looks fairly similar.

[1] https://lwn.net/Articles/593336/

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
