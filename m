From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Apr 2012 08:30:54 +0100
Subject: arm_memblock_steal() API usage
In-Reply-To: <4F7A76B3.3070405@codeaurora.org>
References: <4F7A76B3.3070405@codeaurora.org>
Message-ID: <20120403073053.GO24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 03, 2012 at 09:34:03AM +0530, Taniya Das wrote:
> I have a requirement where I need around ~100 bytes of memory to save  
> contents of
> registers to a non-cached area before going into low power mode.
>
> I did do some analysis on a 1GB RAM device of allocating 8 bytes using  
> the API and the below was the result
> was showing allocating only 8 bytes.
>
> API used : -  arm_memblock_steal(SZ_8, SZ_64K);--> physical address  
> returned is 0x3b1f0000

It's silly to use this for the above purpose.  Why not just use kmalloc
and cache flushing to ensure that the data is pushed out to RAM?

> Also is this API advisable for devices with low system RAM?

No.
