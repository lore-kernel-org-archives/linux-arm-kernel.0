From: schmitzmic@gmail.com (Michael Schmitz)
Date: Sat, 17 Nov 2018 16:00:39 +1300
Subject: [RFC PATCH 01/13] arm: Fix mutual exclusion in arch_gettimeoffset
In-Reply-To: <alpine.LNX.2.21.1811170934300.45@nippy.intranet>
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
 <alpine.LNX.2.21.1811170934300.45@nippy.intranet>
Message-ID: <e6b5fffd-1d40-494d-d59b-f98f3c6c9655@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Finn,

Am 17.11.2018 um 11:49 schrieb Finn Thain:
> On Fri, 16 Nov 2018, Russell King - ARM Linux wrote:
>
>>
>> The EBSA110 is probably in a similar boat - I don't remember whether it
>> had 16MB or 32MB as the maximal amount of memory, but memory was getting
>> tight with some kernels even running a minimalist userspace.
>>
>> So, it's probably time to say goodbyte to the kernel support for these
>> platforms.
>>
>
> Your call.
>
> Note that removing code from mainline won't help users obtain older,
> smaller, -stable kernel releases, free from the bug we were discussing.
> (The bug appeared in Linux v2.6.32.)
>
> BTW, if you did want to boot Linux on a 16 MB system, you do have some
> options.
>
> https://lwn.net/Articles/741494/
> https://lwn.net/Articles/608945/
> https://tiny.wiki.kernel.org/
>
> Contributing to this kind of effort probably has value for IoT
> deployments. I suspect it also cuts a small amount of bloat from a large
> number of other Linux systems.

I boot 4.19 on a system with 14 MB RAM - 10 MB remain for user space 
once the kernel loads. After remote login, 4 MB of that remain free for 
buffers or user code (1.5 MB swapped).
That's with sysvinit - Christian tried to boot a systemd userland on his 
Falcon once, and ran out of memory before swap could be activated.

I shouldn't say 16 or 32 MB are hopeless. And the 2.6 kernels were a lot 
more sluggish to my recollection.

Cheers,

	Michael
