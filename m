From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 14 Dec 2012 09:49:05 +0000
Subject: vexpress compilation error in next-20121127
In-Reply-To: <50CA278D.4030409@websterwood.com>
References: <50B56601.5010305@broadcom.com> <50CA278D.4030409@websterwood.com>
Message-ID: <1355478545.26914.2.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-12-13 at 19:07 +0000, Behan Webster wrote:
> On 11/27/12 20:16, Markus Mayer wrote:
> > Hi Pawel,
> >
> > There seems to be an issue compiling vexpress at this point. The 
> > problem being that vexpress' makefile references reset.o, but there's 
> > no reset.c in arch/arm/mach-vexpress.
> >
> > [...]
> >   CC      arch/arm/mach-bcm/board_bcm.o
> >   LD      arch/arm/mach-bcm/built-in.o
> >   CC      arch/arm/mach-vexpress/v2m.o
> > make[1]: *** No rule to make target `arch/arm/mach-vexpress/reset.o', 
> > needed by `arch/arm/mach-vexpress/built-in.o'.  Stop.
> > make: *** [arch/arm/mach-vexpress] Error 2
> Same issue in mainline now too: arch/arm/mach-vexpress/reset.c is missing.

Yes, I've noticed this myself. It's just that the pull request for the
arm-soc drivers branch went out in the second batch yesterday
(http://article.gmane.org/gmane.linux.kernel/1409413), while the soc one
in the first one. This was a bad decision to split the reset driver from
the main update series, apologies about this.

Pawe?
