From: tdas@codeaurora.org (Taniya Das)
Date: Tue, 03 Apr 2012 09:34:03 +0530
Subject: arm_memblock_steal() API usage
Message-ID: <4F7A76B3.3070405@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi RMK,
I have a requirement where I need around ~100 bytes of memory to save 
contents of
registers to a non-cached area before going into low power mode.

I did do some analysis on a 1GB RAM device of allocating 8 bytes using 
the API and the below was the result
was showing allocating only 8 bytes.

API used : -  arm_memblock_steal(SZ_8, SZ_64K);--> physical address 
returned is 0x3b1f0000

/data/debug/memblock # cat memory

0: 0x00200000..0x3b1effff

1: 0x3b1f0008..0x3b1fffff [0x3b1f0000-0x3b1f0007] only 8 bytes removed.

/data/debug/memblock # cat reserved

0: 0x00204000..0x00c710fb

1: 0x01400000..0x01429b44

2: 0x0ffe0000..0x0ffeffff

3: 0x2d9f3000..0x2d9fffff

4: 0x3b1f0008..0x3b1fffff

But before I can go ahead and use this if you could confirm that it will 
allocate only the size requested or it
will carve out minimum 1MB?
Also is this API advisable for devices with low system RAM?

-- 
Thanks&  Regards,
Taniya Das.

Consultant for Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
