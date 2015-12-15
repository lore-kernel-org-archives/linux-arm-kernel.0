From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 15 Dec 2015 10:22:48 +0100
Subject: [PATCH v3 00/13] ARM: at91: PMC driver rework
In-Reply-To: <20151210180652.40eb8bc4@bbrezillon>
References: <1449248628-3486-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20151210180652.40eb8bc4@bbrezillon>
Message-ID: <20151215092248.GA8574@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen,

Do you mind us taking that through the at91 and arm-soc trees?


On 10/12/2015 at 18:06:52 +0100, Boris Brezillon wrote :
> On Fri,  4 Dec 2015 18:03:35 +0100
> Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
> 
> > Hi,
> > 
> > This patch set is a cleanup that properly separate drivers needing to access the
> > PMC (PM and USB) from the clock driver by exposing the PMC as a syscon.
> > 
> > This also allows to implement a fix for preempt-rt. Currently, at91 platform are
> > crashing when using preempt-rt because the irq handler are transformed in
> > threaded irq handler but at the time the pmc registers its clocks, it is not
> > possible to creat threads, leading to a NULL pointer dereference in the kernel.
> > 
> > The new infrastructure uses polling until it is late enough to register threaded
> > irqs.
> > 
> > Note that there is an ugly global spinlock for the peripheral and generated
> > clocks. More infrastructure is needed in syscon to get rid of that one. We will
> > be working on that.
> 
> To the whole series,
> 
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
