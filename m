From: slash.tmp@free.fr (Mason)
Date: Wed, 25 Mar 2015 15:35:16 +0100
Subject: Cache line size definition in arch/arm/mm/Kconfig
Message-ID: <5512C7A4.3000302@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

AFAICT, L1 cache line size is specified in arch/arm/mm/Kconfig

config ARM_L1_CACHE_SHIFT_6
	bool
	default y if CPU_V7
	help
	  Setting ARM L1 cache line size to 64 Bytes.

config ARM_L1_CACHE_SHIFT
	int
	default 6 if ARM_L1_CACHE_SHIFT_6
	default 5


I'm using a Cortex A9 MPCore. If I'm not mistaken, the cache line size
is 32 bytes, even though this CPU is ARMv7.

http://infocenter.arm.com/help/topic/com.arm.doc.ddi0388g/Caccifbd.html

> The Cortex-A9 processor has separate instruction and data caches.
> The caches have the following features:
>
>   Each cache can be disabled independently. See System Control Register.
>   Both caches are 4-way set-associative.
>   The cache line length is eight words.
>   On a cache miss, critical word first filling of the cache is performed.
>   You can configure the instruction and data caches independently during implementation to sizes of 16KB, 32KB, or 64KB.
>   To reduce power consumption, the number of full cache reads is reduced by taking advantage of the sequential nature of many cache operations. If a cache read is sequential to the previous cache read, and the read is within the same cache line, only the data RAM set that was previously read is accessed.


How do I set ARM_L1_CACHE_SHIFT_6 to 'n' in my platform Kconfig?

Or perhaps I should "override" ARM_L1_CACHE_SHIFT to 5 (again in
my platform Kconfig). I don't know the syntax to do that.

Could someone point out the correct way?

Regards.
