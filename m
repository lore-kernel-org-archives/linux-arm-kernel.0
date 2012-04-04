From: tdas@codeaurora.org (Taniya Das)
Date: Wed, 04 Apr 2012 10:36:05 +0530
Subject: arm_memblock_steal() API usage
In-Reply-To: <20120403073053.GO24211@n2100.arm.linux.org.uk>
References: <4F7A76B3.3070405@codeaurora.org>
 <20120403073053.GO24211@n2100.arm.linux.org.uk>
Message-ID: <4F7BD6BD.7040102@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RMK,

On 03-Apr-12 1:00 PM, Russell King - ARM Linux wrote:
> On Tue, Apr 03, 2012 at 09:34:03AM +0530, Taniya Das wrote:
>> I have a requirement where I need around ~100 bytes of memory to save
>> contents of
>> registers to a non-cached area before going into low power mode.
>>
>> I did do some analysis on a 1GB RAM device of allocating 8 bytes using
>> the API and the below was the result
>> was showing allocating only 8 bytes.
>>
>> API used : -  arm_memblock_steal(SZ_8, SZ_64K);-->  physical address
>> returned is 0x3b1f0000
> It's silly to use this for the above purpose.  Why not just use kmalloc
> and cache flushing to ensure that the data is pushed out to RAM?
We don't want to do a kmalloc and flush, we want to do something similar 
to how OMAP4
does, keeping aside a chunk of RAM for saving the contents. But my only 
concern what will
be the minimum amount of memory allocated by arm_memblock_steal?
>> Also is this API advisable for devices with low system RAM?
> No.


-- 
Thanks&  Regards,
Taniya Das.

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
