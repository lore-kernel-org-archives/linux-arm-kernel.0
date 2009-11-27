From: jamie@shareable.org (Jamie Lokier)
Date: Fri, 27 Nov 2009 01:37:26 +0000
Subject: CAS implementation may be broken
In-Reply-To: <4B0EA95B.20401@45mercystreet.com>
References: <4B08055C.3000408@45mercystreet.com>
	<1258989196.8088.28.camel@pc1117.cambridge.arm.com>
	<4B0BF899.7060106@45mercystreet.com>
	<20091125012406.GB13142@shareable.org>
	<4B0EA95B.20401@45mercystreet.com>
Message-ID: <20091127013726.GB6094@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Toby Douglass wrote:
> Jamie Lokier wrote:
> >Note that pointer-counter is not really reliable.
> 
> [snip case]
> 
> >Of course even if the counter wraps, you still have to be 1/2^32
> >unlucky to see the same value.  But that's enough to make it unreliable.
> 
> I concur, but it's not a problem on 64-bit.

Agree, about 64-bit.  (Until we have much faster CPUs :-)

It's occurred to me that it's possible to make pointer-counter safe.

Simply, when about to wrap, send a signal to every thread.  The signal
handler should check if the thread it has interrupted is inside a
pointer-counter critical section, and if yes, force the interrupted
code to synchronise with all the other threads in another way, such as
using a mutex.

-- Jamie
