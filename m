From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 23 Jan 2011 00:30:43 -0500 (EST)
Subject: [PATCH 1/2] ARM: calculate VMALLOC_END by probing in
	mdesc->map_io()
In-Reply-To: <AANLkTikkiMKseQznf99p3uiL4he_P3TyGLx0XOPuZgHs@mail.gmail.com>
References: <1295737001-19578-1-git-send-email-eric.y.miao@gmail.com>
	<20110122231528.GD11960@n2100.arm.linux.org.uk>
	<AANLkTikkiMKseQznf99p3uiL4he_P3TyGLx0XOPuZgHs@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1101230024240.8580@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 23 Jan 2011, Eric Miao wrote:

> On Sun, Jan 23, 2011 at 7:15 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > I'd instead suggest adding vmalloc_end to the machine description
> > record.
> >
> 
> And since all boards sharing a same machine_class is going to use
> the same value, I'd rather we first introduce struct machine_class
> like in the patch I posted months ago?

Can we possibly get away with a global VMALLOC_END?  What if we were to 
decide it is fixed at 0xf0000000 for everyone?


Nicolas
