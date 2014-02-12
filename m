From: will.deacon@arm.com (Will Deacon)
Date: Wed, 12 Feb 2014 13:46:55 +0000
Subject: [PATCH v2 0/9] ARM: multi-platform kconfig cleanup and mach-virt
 removal
In-Reply-To: <201402121426.41914.arnd@arndb.de>
References: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
 <201402121426.41914.arnd@arndb.de>
Message-ID: <20140212134655.GC29132@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 01:26:41PM +0000, Arnd Bergmann wrote:
> On Tuesday 11 February 2014, Rob Herring wrote:
> > The previous version [1] was mainly a discussion about v6 vs. v6K.
> > Several platforms have this wrong and incorrectly select v6 when the
> > more optimal v6K option could be used. After more research, my memory
> > about i.MX31 was wrong and it does need to remain v6.
> 
> Just curious: do you have more information on this? Are all i.MX31 ARMv6
> and all i.MX35 v6k as the current Kconfig claims,  or is it more
> complicated?

Slightly tangential, but the one to watch out for is 1136. Prior to r1 (i.e.
r0pX), it is v6 but r1pX+ are v6k (without SMP).

> * integrator and realview apparently allow both CPU_V6 and CPU_V6K
>   to be manually selected. Is that actually the correct behavior
>   in that both kinds of core tiles exist?

I have 1136 r0p1 on an integrator CP, so I suppose it could also take an
1136 r1pX without any trouble.

Will
