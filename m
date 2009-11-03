From: hzpeterchen@gmail.com (Peter Chen)
Date: Tue, 03 Nov 2009 11:10:41 +0800
Subject: Why flush_cache_all() not including flushing L2 cache if the
	system has L2 cache?
In-Reply-To: <20091102110007.GC1133@n2100.arm.linux.org.uk>
References: <4AEE44AD.4010604@gmail.com>
	<20091102110007.GC1133@n2100.arm.linux.org.uk>
Message-ID: <4AEF9F31.5000008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Mon, Nov 02, 2009 at 10:32:13AM +0800, Peter Chen wrote:
>> I met a problem if the address is first used by cachable, then  
>> uncachable. After that, the address will be filled with cachable value
>> after that L2 cache line is evicted.
> 
> What _exactly_ are you trying to do?  Why are you apparantly mapping
> something in as cacheable, and then making it uncacheable?
> 
This is 3rd party released code

This problem happens at device driver wants to alloc uncachable memory, 
but it doesn't alloc it using dma_ API.

-- 
Best regards,
Peter Chen
