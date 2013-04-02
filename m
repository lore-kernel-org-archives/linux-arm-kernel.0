From: olof@lixom.net (Olof Johansson)
Date: Tue, 2 Apr 2013 11:37:54 -0700
Subject: How to facilitate the cpuidle drivers to go to the same
 direction (Was: Re: [PATCH 4/9] ARM: OMAP4: cpuidle: fix wrong driver
 initialization)
In-Reply-To: <1364804988.32247.3.camel@pasglop>
References: <1364553095-25110-4-git-send-email-daniel.lezcano@linaro.org>
 <51556F1D.5030208@ti.com> <515570DF.5010608@linaro.org>
 <CAP245DX+mYQhhJ-fU6PQdV6V-1P7PGUaOoNo+QdhRFaQR=wiEQ@mail.gmail.com>
 <51558723.1050904@ti.com>
 <CAP245DWAAgQ4co34mdkFgepC5kP9v0n6B954ej2X_y20LE9kSQ@mail.gmail.com>
 <5155AEE7.106@ti.com> <5155B85F.6030808@linaro.org>
 <515923C7.8040408@linux.vnet.ibm.com>
 <1364804988.32247.3.camel@pasglop>
Message-ID: <20130402183754.GN25867@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 01, 2013 at 10:29:48AM +0200, Benjamin Herrenschmidt wrote:
> On Mon, 2013-04-01 at 11:35 +0530, Deepthi Dharwar wrote:
> > But then, this means we get all the
> > arch specific code out under drivers/cpuidle
> > which can be very messy.
> 
> Not really no. We already have that here or there in other drivers,
> it's not necessarily messy and the stuff like that can generally be made
> reasonably self contained.
> 
> The main issue is that if I (powerpc) wants a fix in my
> some_ppc_box_idle.c driver, especially if it needs to sync with other
> arch changes, having to sync/ack with Rafael might complicate things a
> bit (though not necessarily a lot).
> 
> I would probably keep the liberty of sending to Linus directly urgent
> bug/regression fixes to individual cpuidle drivers relating to our archs
> without waiting every now and then if for example Rafael is on
> vacation :-)

Merging them all over sounds like a good idea to me as well.

This isn't too different from how we handle other subsystems; as
architecutre maintainer you just use your judgement on what needs an ack
vs cc. Some smaller details about how the backend of the driver works
on a platform is quite different from refactoring portions of the
framework.


-Olof
