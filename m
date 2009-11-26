From: trd@45mercystreet.com (Toby Douglass)
Date: Thu, 26 Nov 2009 17:14:19 +0100
Subject: CAS implementation may be broken
In-Reply-To: <20091125012406.GB13142@shareable.org>
References: <4B08055C.3000408@45mercystreet.com>
	<1258989196.8088.28.camel@pc1117.cambridge.arm.com>
	<4B0BF899.7060106@45mercystreet.com>
	<20091125012406.GB13142@shareable.org>
Message-ID: <4B0EA95B.20401@45mercystreet.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jamie Lokier wrote:
> Toby Douglass wrote:

>> Interestingly, I saw a day or two ago that there is a double-word 
>> version of LDREX.  The atomic-ptr project, which forms the basis of the 
>> GCC garbage collector, relies on this; it does not in fact use LL/SC on 
>> ARM, but rather uses double-word CAS using a pointer-counter pair.

> Note that pointer-counter is not really reliable.

[snip case]

> Of course even if the counter wraps, you still have to be 1/2^32
> unlucky to see the same value.  But that's enough to make it unreliable.

I concur, but it's not a problem on 64-bit.
