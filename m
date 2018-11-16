From: fthain@telegraphics.com.au (Finn Thain)
Date: Sat, 17 Nov 2018 09:49:48 +1100 (AEDT)
Subject: [RFC PATCH 01/13] arm: Fix mutual exclusion in arch_gettimeoffset
In-Reply-To: <20181116174705.GY30658@n2100.armlinux.org.uk>
References: <cover.1541995959.git.fthain@telegraphics.com.au>
 <d1559db8eddb5b06747b152ae69b63c3aa66ed09.1541995959.git.fthain@telegraphics.com.au>
 <20181112083422.GA19695@infradead.org>
 <alpine.LNX.2.21.1811131420150.362@nippy.intranet>
 <20181113092012.GI30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811140854280.371@nippy.intranet>
 <20181113234336.GP30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811141142490.8@nippy.intranet>
 <20181114141632.GT30658@n2100.armlinux.org.uk>
 <alpine.LNX.2.21.1811151427210.19@nippy.intranet>
 <20181116174705.GY30658@n2100.armlinux.org.uk>
Message-ID: <alpine.LNX.2.21.1811170934300.45@nippy.intranet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Nov 2018, Russell King - ARM Linux wrote:

> 
> The EBSA110 is probably in a similar boat - I don't remember whether it 
> had 16MB or 32MB as the maximal amount of memory, but memory was getting 
> tight with some kernels even running a minimalist userspace.
> 
> So, it's probably time to say goodbyte to the kernel support for these 
> platforms.
> 

Your call.

Note that removing code from mainline won't help users obtain older, 
smaller, -stable kernel releases, free from the bug we were discussing. 
(The bug appeared in Linux v2.6.32.)

BTW, if you did want to boot Linux on a 16 MB system, you do have some 
options.

https://lwn.net/Articles/741494/
https://lwn.net/Articles/608945/
https://tiny.wiki.kernel.org/

Contributing to this kind of effort probably has value for IoT 
deployments. I suspect it also cuts a small amount of bloat from a large 
number of other Linux systems.

-- 
