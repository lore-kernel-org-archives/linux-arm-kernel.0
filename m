From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 17 Sep 2013 15:16:52 -0300
Subject: mvebu: Armada XP doesn't boot in v3.12-rc1
In-Reply-To: <20130917180957.GI19937@titan.lakedaemon.net>
References: <20130917173502.GA4231@localhost>
 <20130917180957.GI19937@titan.lakedaemon.net>
Message-ID: <20130917181650.GB4231@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 02:09:57PM -0400, Jason Cooper wrote:
> On Tue, Sep 17, 2013 at 02:35:03PM -0300, Ezequiel Garcia wrote:
[...]
> 
> > FWIW, CONFIG_HAVE_ARM_ARCH_TIMER=y is also needed or the board freezes,
> > but that's another problem which I'm currently investigating.
> 
> Sounds like we just need a select, is there something more to it?
> 

I've no idea!

Let me spend some time bisecting the problem and see if we can come
up with something smarter.

I'm not sure, but I can't see why a non architected timer kernel wouldn't work.

Let's add Stephen Boyd in Cc, in case he has some idea.
Stephen: when v3.12-rc1 boots with CONFIG_HAVE_ARM_ARCH_TIMER=n (the
default) the kernel freezes at the typical:

  l2x0: 32 ways, CACHE_ID 0x00000100, AUX_CTRL 0x1a69ef12, Cache size: 2048 kB
  sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 4294967286ms
  Console: colour dummy device 80x30
  Calibrating delay loop...

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
