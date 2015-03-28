From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 28 Mar 2015 14:24:02 +0100
Subject: [PATCH v4 2/4] mfd: lubbock_cplds: add lubbock IO board
In-Reply-To: <87fv8pwmm0.fsf@free.fr>
References: <20150216130549.GF14545@x1> <201503280335.16280.arnd@arndb.de>
 <87fv8pwmm0.fsf@free.fr>
Message-ID: <201503281424.02583.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 28 March 2015, Robert Jarzmik wrote:
> It's not as much a problem as a generic question : does a driver belong to
> arch/* ?
> 
> Personaly it would have been far simpler for me to have it through the pxa tree,
> but I want to be sure it's the right place. Others will follow, pxa mainstone is
> such a candidate.
> 
> I was thinking so far that arch/arm/mach-* was for machine description,
> ie. wirings, interconnections, initial setup etc ... The "driver" part, ie. code
> really driving dynamics in IPs was as per my understanding in drivers/...
> 
> Now I can create arch/arm/mach-pxa/lubbock_cplds.c, that won't make any
> difference to me, provided that it's the right thing to do.

If we had a lot of these, we would probably put them somewhere under drivers.
and find a maintainer for them. Given that this is an exceptional case for
an older machine, my feeling is that leaving the code in mach-pxa is the least
effort for now.

	Arnd
