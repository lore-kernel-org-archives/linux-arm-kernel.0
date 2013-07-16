From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 16 Jul 2013 11:18:51 -0300
Subject: [PATCH 05/10] watchdog: orion: Add a memory resource for RSTOUT
 register
In-Reply-To: <20130716140415.GB19448@lunn.ch>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1373931163-12670-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130716140415.GB19448@lunn.ch>
Message-ID: <20130716141850.GB23904@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Tue, Jul 16, 2013 at 04:04:15PM +0200, Andrew Lunn wrote:
> On Mon, Jul 15, 2013 at 08:32:38PM -0300, Ezequiel Garcia wrote:
> > Instead of accessing the RSTOUT register directly, this commit
> > adds a platform memory resource to map this register into the driver.
> 
> 
> Have you looked at:
> 
> arch/arm/mach-mvebu/system-controller.c
> 

Mmm... I saw the use of the RSTOUT register in kirkwood_restart()
but wasn't sure who should be the real 'owner' of this register.

> It is also using this register. Are we going to have a similar problem
> as the TIMER_CTRL register, which you refactered in an earlier patch?
> 

Probably.

> "marvell,orion-system-controller" is not actually used yet, but once
> kirkwood moves into mach-mvebu, it will start using it.
> 

I guess so. We should take that into account *now*. Let me think about
it and see if I can have something sane for v2.

Thanks!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
