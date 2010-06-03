From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 03 Jun 2010 17:15:09 +0100
Subject: PB1176 broken in 2.6.35-rc1, bisected
In-Reply-To: <AANLkTimJkaadEM1xvG30WVvEjJPZQXHwx216SeqWFKNp@mail.gmail.com>
References: <AANLkTikoCy2FH_5ICh-iiI_wzGj6D6oszyM-zCXkNC_4@mail.gmail.com>
	<1275518783.27834.2.camel@e102109-lin.cambridge.arm.com>
	<AANLkTimJkaadEM1xvG30WVvEjJPZQXHwx216SeqWFKNp@mail.gmail.com>
Message-ID: <1275581709.8775.14.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-06-03 at 09:48 +0100, Linus Walleij wrote:
> 2010/6/3 Catalin Marinas <catalin.marinas@arm.com>:
> > On Wed, 2010-06-02 at 23:33 +0100, Linus Walleij wrote:
> >> my PB1176 doesn't boot properly in 2.6.35-rc1, it goes to this point
> >> and hangs:
> >>
> >> (...)
> >> Switching to clocksource timer3
> >> NET: Registered protocol family 2
> >> IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
> >> TCP established hash table entries: 4096 (order: 3, 32768 bytes)
> >> TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
> >> TCP: Hash tables configured (established 4096 bind 4096)
> >> TCP reno registered
> >> UDP hash table entries: 256 (order: 0, 4096 bytes)
> >> UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
> >> NET: Registered protocol family 1
> >> RPC: Registered udp transport module.
> >> RPC: Registered tcp transport module.
> >> RPC: Registered tcp NFSv4.1 backchannel transport module.
> >
> > Have you tried disabling CONFIG_CACHE_L2X0?
> 
> Hey it works! :-)
> 
> I suppose your latest patches will hopefully  get the defconfig with
> l2x0 working again in -rc2 if they're merged?

I think there is an L2 erratum (and trying to get the right workaround).
It may be triggered by commit e7c5650f6.

I'll get back on the list with a patch.

-- 
Catalin
