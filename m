From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 4 Jun 2012 14:30:59 +0000
Subject: Kernel 3.4 on Dreamplug: no serial console
In-Reply-To: <2396575.dLS9zmzUSD@flexo>
References: <loom.20120602T135715-548@post.gmane.org>
 <20120603184049.GF14756@titan.lakedaemon.net> <2396575.dLS9zmzUSD@flexo>
Message-ID: <201206041430.59397.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 June 2012, Florian Fainelli wrote:
> On Sunday 03 June 2012 14:40:49 Jason Cooper wrote:
> > On Sun, Jun 03, 2012 at 05:12:18PM +0000, Arnd Bergmann wrote:
> > > I'd also accept a patch to make ARCH_KIRKWOOD_DT select OF_SERIAL if 
> people
> > > prefer that, but I think just changing the defconfig is better.
> > 
> > I'd prefer the defconfig as there are situations where users/oems deploy
> > a kernel without support for serial console.  In order to do that with
> > your patch, or similar approaches, they would have to change the code.
> > With defconfig, they don't.
> 
> Should not you rather select OF_SERIAL and add a status propery to the uart 
> node in device tree, so that it is up to dtb provider to determine whether 
> this device node should be enabled or not? You would avoid all kind of 
> defconfig issue.

Obviously the configuration comes from DT, but there are still reasons to
not select the driver. E.g. you might want to build a kernel that runs on
a wide variety of systems and has all drivers as loadable modules rather than
built-in. There are also some systems that are rather memory constraint and
even disable printk support, so the console becomes useless too.

	Arnd
