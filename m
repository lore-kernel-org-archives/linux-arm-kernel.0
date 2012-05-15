From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 May 2012 15:32:20 +0000
Subject: [PATCH 6/8] arm: mach-armada: add support for Armada XP board
 with device tree
In-Reply-To: <4FB2714F.5080703@codethink.co.uk>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120515165813.66b4434e@skate> <4FB2714F.5080703@codethink.co.uk>
Message-ID: <201205151532.21143.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 May 2012, Ben Dooks wrote:
> >
> > Agreed. When looking at the code, I wasn't sure why PCI mappings were
> > needed so early. Surely, the minimal mappings to get an UART are quite
> > useful to have very early, but why PCI?
> 
> I think it was because that PCI was initialised early and requires a
> large mapping space. It is very likely to be legacy kernel stuff that
> people have kept copying through.
> 

No, as Rob pointed out, we might not need them early, but we definitely
want a fixed address for the PIO window, which ioremap does not
provide.

	Arnd
