From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 7 Jun 2013 19:16:51 +0200
Subject: [PATCH 2/5] arm: preserve ATAGS in /chosen/atags in the Device
 Tree
In-Reply-To: <20130607143249.GR23859@titan.lakedaemon.net>
References: <1370414409-29991-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370414409-29991-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130606142851.6dd17cad@skate>
 <alpine.LFD.2.03.1306061253430.18597@syhkavp.arg>
 <20130607112101.2cedbc5f@skate>
 <20130607143249.GR23859@titan.lakedaemon.net>
Message-ID: <20130607191651.0baa1c7d@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Fri, 7 Jun 2013 10:32:49 -0400, Jason Cooper wrote:

> > Well, I don't think what you say here is really fair. Before the DT was
> > in place, unless I missed it, there was no standard way of letting the
> > bootloader pass MAC addresses to the kernel. And Marvell's development
> > on those Armada 370/XP platforms predates the introduction of the
> > Device Tree in the Linux kernel (the code we have originally been give
> > was a 2.6.3x), so it's really not their fault to not have a DT-capable
> > bootloader at this point.
> 
> To be accurate, I think Nico is referring to the fact that Marvell
> assigned their own ATAG without going through Russell.

Right, that's true.

> However, just like mach-types, are we assigning any new atags?  Can we
> consider them deprecated?  If so, that changes the game.  Then what
> Thomas is proposing is a "legacy compatibility" patch, as opposed to a
> hole vendors can use to do their own thing.
> 
> We could add Arnd's suggestion of a time bomb on the common code in
> atags_to_fdt.c to prevent mis-use.
> 
> I'm not 100% convinced of this, and I actually tend to agree with Nico
> here, but I'd also like to find a workable solution.

I perfectly understand Nico and Russell concerns, for sure. But I'd
also like to find a workable solution:
 
 * Passing the MAC address on the kernel command line is not something
   that the network maintainer likes. See
   http://lists.openwall.net/netdev/2011/11/17/82 and Dave Miller's
   answer http://lists.openwall.net/netdev/2011/11/17/83.

 * Parsing the U-Boot environment is really not easy. How does the
   kernel know where this environment is located? What if another
   bootloader than U-Boot is used? Reading the U-Boot environment from
   the kernel sounds clunky.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
