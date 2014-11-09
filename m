From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 9 Nov 2014 10:41:50 +0100
Subject: [PATCH 0/7] Armada 375/38x perf support, and a bonus irqchip
 driver simplification
In-Reply-To: <20141109052348.GT3698@titan.lakedaemon.net>
References: <1413985427-20918-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20141109052348.GT3698@titan.lakedaemon.net>
Message-ID: <20141109104150.03044ee0@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason, Ezequiel,

On Sun, 9 Nov 2014 00:23:48 -0500, Jason Cooper wrote:
> On Wed, Oct 22, 2014 at 10:43:40AM -0300, Ezequiel Garcia wrote:
> > This patchset enables support for perf hardware events, by enabling the PMU
> > interrupts in the irqchip driver.
> > 
> > While doing this, we noticed the driver could use some cleaning to simplify
> > the overly complex implementation of the .map(), .unmask() and .mask()
> > functions.
> > 
> > The first three patches are the result of this cleaning effort, while the
> > rest of the series is the Perf support for Armada 375 and Armada 38x SoCs.
> > 
> > The series is based on v3.18-rc1.
> > 
> > Ezequiel Garcia (7):
> >   irqchip: armada-370-xp: Simplify interrupt map, mask and unmask
> >   irqchip: armada-370-xp: Initialize per cpu registers when CONFIG_SMP=N
> >   irqchip: armada-370-xp: Introduce a is_percpu_irq() helper for
> >     readability
> >   irqchip: armada-370-xp: Enable Performance Counter interrupts
> 
> Patches 1 to 4 tentatively applied to irqchip/mvebu.  Things have been
> quiet, so let's get it in next for some more test coverage.

Ezequiel, are these patches really the version we want to see merged? I
think you're working on a different implementation that demultiplex the
coherency fabric events interrupt.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
