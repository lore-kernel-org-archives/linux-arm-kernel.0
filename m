From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Fri, 12 Oct 2012 14:08:12 +0200
Subject: alignment faults in 3.6
In-Reply-To: <20121012114443.GG21164@n2100.arm.linux.org.uk>
References: <20121005082439.GF4625@n2100.arm.linux.org.uk>
 <AE90C24D6B3A694183C094C60CF0A2F6026B703E@saturn3.aculab.com>
 <yw1xtxu1nfsn.fsf@unicorn.mansr.com> <201210120811.43290.arnd@arndb.de>
 <20121012090321.GA21164@n2100.arm.linux.org.uk>
 <yw1xhaq0nefg.fsf@unicorn.mansr.com>
 <20121012110750.GE21164@n2100.arm.linux.org.uk>
 <yw1x8vbcndlb.fsf@unicorn.mansr.com>
 <20121012114443.GG21164@n2100.arm.linux.org.uk>
Message-ID: <1350043692.21172.11815.camel@edumazet-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-10-12 at 12:44 +0100, Russell King - ARM Linux wrote:

> - You were demanding that the ipv4 header structure should be packed.
>   I said that wasn't going to happen because the networking people
>   wouldn't allow it, and it seems that's been proven correct.
> - You were demanding that the ipv4 code used the unaligned accessors.
>   I said that networking people wouldn't allow it either, and that's
>   also been proven correct.
> 
> Both these points have been proven correct because Eric has said that the
> core networking code is _not_ going to be changed to suit this.
> 
> What Eric _has_ said is that networking people consider packets supplied
> to the networking layer where the IPv4 header is not aligned on architectures
> where misaligned accesses are a problem to be a bug in the network driver,
> not the network code, and proposed a solution.
> 
> That's entirely different from all your claims that the core networking
> code needs fixing to avoid these misaligned accesses.

It seems we agree then, but your words were a bit misleading (at least
for me)

So yes, we built network stack with the prereq that IP headers are
aligned, but unfortunately many developers use x86 which doesnt care, so
its possible some bugs are added.

But its not by intent, only by accident.

Thanks
