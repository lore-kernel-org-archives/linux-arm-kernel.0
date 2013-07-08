From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 8 Jul 2013 10:45:47 +0200 (CEST)
Subject: [GIT PULL] clockevents/clocksource: Add Marvell Orion SoC
 timer
In-Reply-To: <20130707235819.GB11908@titan.lakedaemon.net>
References: <51B8D310.4050404@linaro.org> <51D9548B.9040907@gmail.com>
 <alpine.DEB.2.02.1307071508030.32106@ionos.tec.linutronix.de>
 <20130707144645.GA11908@titan.lakedaemon.net>
 <alpine.DEB.2.02.1307071723220.32106@ionos.tec.linutronix.de>
 <20130707235819.GB11908@titan.lakedaemon.net>
Message-ID: <alpine.DEB.2.02.1307081041290.32106@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 7 Jul 2013, Jason Cooper wrote:
> On Sun, Jul 07, 2013 at 05:30:31PM +0200, Thomas Gleixner wrote:
> I don't mind delaying half of a series so the drivers/ portion can land
> in mainline, and the rest can land in the next cycle.  But when things
> don't go according to that plan, I'd like a little consideration /
> flexibility about solving the problem.  Especially considering I'm
> *trying* to do the right thing by pushing to appropriate maintainers
> first.
> 
> Of course, this is a moot point since, as you clarified above, this
> dependency doesn't have the hazards typically associated with
> out-of-tree dependencies.

There is a very simple procedure for stuff like this.

Series has parts which go through tree A and B and another larger part
for tree C which depends on the A and B parts.

So ask the maintainers of A and B to apply this to separate branches,
which are based on some commit in Linus tree. These branches can be
pulled into C and C can apply the depending stuff on top.

Now the maintainers of A and B merge these branches into their main
devel branch, can do further fixups and stuff on top. And the whole
thing just works without glitches during the merge window.

We do this all the time.

Thanks,

	tglx
