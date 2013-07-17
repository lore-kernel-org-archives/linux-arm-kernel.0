From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Jul 2013 09:51:39 +0100
Subject: BUG: commit "ARM: Remove __ARCH_WANT_INTERRUPTS_ON_CTXSW on
 pre-ARMv6 CPUs" breaks armv5 with CONFIG_PREEMPT
In-Reply-To: <51E658AF.1090009@pengutronix.de>
References: <20130620095705.GA18536@arm.com> <51C2D5EF.3040803@pengutronix.de>
 <20130620102856.GC18536@arm.com> <20130620111255.GD18536@arm.com>
 <51C2E917.9000708@pengutronix.de> <51C2EA04.4060701@pengutronix.de>
 <51C2EBCD.4070206@pengutronix.de> <51C42AE0.9070506@pengutronix.de>
 <20130621135219.GC4099@arm.com> <51E658AF.1090009@pengutronix.de>
Message-ID: <20130717085139.GJ24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 10:41:19AM +0200, Marc Kleine-Budde wrote:
> What happend to that patch? I cannot find it in v3.10.x nor in linus/master.

Catalin sent it to me, and I didn't apply it because it's still racy.

We have stateful context switches (due to cache clearing) and this does
nothing to solve the problem there.  If we get preempted during the
cache clearing, things will still go wrong.

See:

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7771/1

I've no idea what's happening about this.  It looks to me like nothing
happened after Catalin's last comment there.
