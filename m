From: trd@45mercystreet.com (Toby Douglass)
Date: Fri, 06 Nov 2009 20:17:47 +0100
Subject: GCC built-in atomic operations and memory barriers
In-Reply-To: <4AF1FBA4.4070307@xenomai.org>
References: <4AF1C361.8090405@45mercystreet.com>
	<20091104190544.GA518@n2100.arm.linux.org.uk>
	<4AF1FBA4.4070307@xenomai.org>
Message-ID: <4AF4765B.5080303@45mercystreet.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gilles Chanteperdrix wrote:
> Russell King - ARM Linux wrote:
>> The kernel API is the syscall interface and associated data structures.
>> It does not include everything you can find in kernel headers.
> 
> Are the functions found in the vectors page part of the kernel API?
> Because if that is so, then they provide a way to implement cmpxchg and
> barriers in user-space.

GCC (I had overlooked this) has a function, __sync_synchronize(), which 
provides a full memory barrier.  I do not know how it is implemented on 
ARM, but the CAS I wrote certainly would not work (and did not work) 
without a memory barrier and with this function inserted, does work.

The GCC atomic CAS for ARM appears to call the OS's compare-exchange 
function, which certainly is broken, by lacking memory barriers, on the 
Linux I am developing on.

Either way, I now have my own platform independent ARM __asm__ for LL/CS 
CAS, with memory barriers, so I'm happy.  Also, I got my OpenGL wrapper 
DLL working last night :-)
