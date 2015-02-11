From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 11 Feb 2015 14:38:59 +0100
Subject: [PATCH v4 3/5] irqchip: Add DT binding doc for the virtual irq
 demuxer chip
In-Reply-To: <20150211123656.GG9154@leverpostej>
References: <1422527620-8308-1-git-send-email-boris.brezillon@free-electrons.com>
 <1422527620-8308-4-git-send-email-boris.brezillon@free-electrons.com>
 <20150210153628.GF9432@leverpostej>
 <20150210165201.634bc04b@bbrezillon>
 <20150210204835.GL9432@leverpostej>
 <20150211095339.0a2e4e7b@bbrezillon>
 <20150211111106.GA9154@leverpostej>
 <20150211132437.0753a7da@bbrezillon>
 <20150211123656.GG9154@leverpostej>
Message-ID: <20150211133859.GC3971@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/2015 at 12:36:56 +0000, Mark Rutland wrote :
> > Actually, that was one of the requirements expressed by Thomas (Thomas,
> > correct me if I'm wrong).
> > The point was to force shared irq users to explicitly specify that they
> > are mixing !IRQF_NO_SUSPEND and IRQF_NO_SUSPEND because they have no
> > other choice.
> > 
> > With your patch, there's no way to inform users that they are
> > erroneously setting the IRQF_NO_SUSPEND flag on one of their shared
> > interrupt.
> 
> Sure, but even with the demux that's still the case (because it pretends
> that this mismatch is a HW property rather than a property of the set of
> drivers sharing the interrupt).
> 
> Whether there's a demux node in the DTB is entirely separate from
> whether the drivers can actually handle the situation.
> 
> So if we need a warning in the presence of mismatch and action masking,
> we need the exact same warning with the demux.
> 

Actually, we only care about removing the warning. It is effectively the
HW that forces us to do so. So we would be completely happy with a new
flag to silence the warning as we know what we are doing (I think that
has already been suggested).

> The presence of a demux implies the DTB author believes they have solved
> the problem with the demux, not necessarily that they have considered
> the situation and updated drivers appropriately. Relying on the demux to
> imply that everything is fine only gives us the illusion that everything
> is fine.
> 

Whatever the solution, it could be used as a workaround the warning as
this is exactly what we need for our platform.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
