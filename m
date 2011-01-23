From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 23 Jan 2011 09:21:19 -0500 (EST)
Subject: [PATCH 1/2] ARM: calculate VMALLOC_END by probing in
	mdesc->map_io()
In-Reply-To: <AANLkTikkiMKseQznf99p3uiL4he_P3TyGLx0XOPuZgHs@mail.gmail.com>
References: <1295737001-19578-1-git-send-email-eric.y.miao@gmail.com>
	<20110122231528.GD11960@n2100.arm.linux.org.uk>
	<AANLkTikkiMKseQznf99p3uiL4he_P3TyGLx0XOPuZgHs@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1101230918340.8580@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 23 Jan 2011, Eric Miao wrote:

> > I'd instead suggest adding vmalloc_end to the machine description
> > record.
> >
> 
> And since all boards sharing a same machine_class is going to use
> the same value, I'd rather we first introduce struct machine_class
> like in the patch I posted months ago?

Another way to look at it is to move vmalloc_end and the like into each 
machine record now, and look at the machine class changes afterwards 
with a better view of all that might be consolidated at that point.


Nicolas
