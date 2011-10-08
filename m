From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sat, 8 Oct 2011 13:36:21 -0400 (EDT)
Subject: [PATCH 18/26] ARM: pxa: MTD_XIP is not actually working any more
In-Reply-To: <CAMPhdO88OdwjfERo=Ri_-_xR75S53d-HKW1Ah0WGnu_0P1gRXQ@mail.gmail.com>
References: <1317499438-14058-1-git-send-email-arnd@arndb.de>
	<1317499438-14058-19-git-send-email-arnd@arndb.de>
	<CAMPhdO88OdwjfERo=Ri_-_xR75S53d-HKW1Ah0WGnu_0P1gRXQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1110081126150.6390@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 8 Oct 2011, Eric Miao wrote:

> On Sun, Oct 2, 2011 at 4:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > The headers files required for XIP support have moved around
> > over the last few years, and the code no longer builds.
> > Until someone fixes this, let's just disable support, leaving
> > sa1100 as the only platform still supporting xip.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> It is actually fixable, the problem is really mtd-xip.h is referencing
> the interrupt registers directly which I moved them to mach-pxa/irq.c
> for better modularization.
> 
> I'm fine to drop XIP. I'm afraid Nico's gonna be a bit disappointed
> as I broke his favorite XIP code :-)

Well, I don't care much myself.  I have no use for that capability, even 
though this was interesting to implement.  So it only depends if someone 
relies on this or not.

A few months ago I asked on the list if XIP was still useful, and Tim 
Bird replied that Sony was indeed using it.  So if this is not too hard 
to keep this feature alive then I'd go with that option.


Nicolas
