From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 14 Dec 2017 15:34:13 -0600
Subject: [PATCH] arm64: fix CONFIG_DEBUG_WX address reporting
In-Reply-To: <673df793-cc4c-b251-6846-7cba4931ff53@redhat.com>
References: <bff5a2b3-0d93-5f55-c129-4b14a5a09b45@codeaurora.org>
 <680ec27a-1557-f2d9-8159-bd49326bd36c@redhat.com>
 <20171213115835.pkt3fyqcbk7lgdeb@lakrids.cambridge.arm.com>
 <673df793-cc4c-b251-6846-7cba4931ff53@redhat.com>
Message-ID: <825594ef-4db5-ec71-9ad8-81f447993251@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14/2017 01:02 PM, Laura Abbott wrote:
> 
> While we're fixing this up, do you want to drop the %p from the
> "Found insecure W+X" message from above since pointer hashing
> renders it kind of pointless or switch it to %px?

Switching to %px gives me:

arm64/mm: Found insecure W+X mapping at address 
ffff2b1b4e512000/0xffff2b1b4e512000

Looks the same as before.

However, when I try to dump the contents of memory at that address via 
print_hex_dump(), I get an "Unable to handle kernel paging request" oops.

[   11.236091] Unable to handle kernel paging request at virtual address 
ffff2b1b4e512000
[   11.243985] pgd = ffff2b1b55a0d000
[   11.247371] [ffff2b1b4e512000] *pgd=00000007ffffe003, 
*pud=00000007ffffd003, *pmd=000000079972a003, *pte=0000000000000000


-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
