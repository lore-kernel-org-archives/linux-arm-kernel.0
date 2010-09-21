From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 21 Sep 2010 15:33:22 +0200
Subject: [PATCH v2 2/3] [ARM] tegra: add PCI Express support
In-Reply-To: <cfbe99c95d8d0ed7b5e139afc44ddaac@cox.rootnode.net>
References: <cover.1285070872.git.mike@compulab.co.il>
	<201009211430.00325.arnd@arndb.de>
	<cfbe99c95d8d0ed7b5e139afc44ddaac@cox.rootnode.net>
Message-ID: <201009211533.23089.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 21 September 2010, Pawel Moll wrote:
> >>  #define __io(a)         __io(a)
> >>  #define __mem_pci(a)    (a)
> > 
> > I wonder what the #else path is for. If you don't have PCI, who would
> > call __io? And wouldn't that result in a NULL pointer dereference?
> 
> If I remember correctly the legacy IDE (ATA) code is scanning "well
> known" IO port numbers...

Right, that's the sort of thing I was worried about. I don't think
IDE is a problem here though, because it would only get probed
if you have a PCI/system/platform/of device registered to the
system, which normally doesn't happen.

	Arnd
