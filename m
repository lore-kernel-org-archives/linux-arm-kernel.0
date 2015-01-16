From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Jan 2015 17:56:57 +0100
Subject: Regression with legacy IRQ numbers caused by 9a1091ef0017
In-Reply-To: <20150115153746.GC18552@atomide.com>
References: <20150114221407.GS2419@atomide.com>
 <87wq4ogl48.fsf@approximate.cambridge.arm.com>
 <20150115153746.GC18552@atomide.com>
Message-ID: <3822486.YZLIqXdAgt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 January 2015 07:37:48 Tony Lindgren wrote:
> * Marc Zyngier <marc.zyngier@arm.com> [150115 06:46]:
> > On Thu, Jan 15 2015 at  2:27:56 pm GMT, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Thursday 15 January 2015 13:42:57 Marc Zyngier wrote:
> > Probably there is a workable strategy, but my knowledge about OMAP is
> > close to *nothing*...
> 
> I have a feeling this might bite other platforms too and we just have
> not noticed it yet..

I'm looking through the entire tree now, scanning for machines that have
GIC and use IORESOURCE_IRQ or DEFINE_RES_IRQ in their platform code.
Most platforms using GIC are completely converted to DT and have no
hardcoded legacy IRQs.

I have checked that cns3xxx and realview are both fine by inspection.

The only one I'm not sure about is shmobile, which looks like it might
suffer from the same problem. Simon/Magnus, could you verify this
with a multiplatform kernel on any SoC that has GIC and uses devices
that have interrupts defined in setup-*.c or board-*.c?

	Arnd
