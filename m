From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 15 May 2012 17:46:02 +0200
Subject: [PATCH 6/8] arm: mach-armada: add support for Armada XP board
 with device tree
In-Reply-To: <201205151532.21143.arnd@arndb.de>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120515165813.66b4434e@skate> <4FB2714F.5080703@codethink.co.uk>
 <201205151532.21143.arnd@arndb.de>
Message-ID: <20120515174602.26d02f70@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 15 May 2012 15:32:20 +0000,
Arnd Bergmann <arnd@arndb.de> a ?crit :

> > > Agreed. When looking at the code, I wasn't sure why PCI mappings
> > > were needed so early. Surely, the minimal mappings to get an UART
> > > are quite useful to have very early, but why PCI?
> > 
> > I think it was because that PCI was initialised early and requires a
> > large mapping space. It is very likely to be legacy kernel stuff
> > that people have kept copying through.
> 
> No, as Rob pointed out, we might not need them early, but we
> definitely want a fixed address for the PIO window, which ioremap
> does not provide.

A fixed address for the PIO window of the PCI registers? Or a fixed
address for the PIO window used to access UART registers?

I would understand why a fixed address is needed for the latter, but
not really for the former.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
