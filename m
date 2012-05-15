From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 May 2012 14:25:30 +0000
Subject: [PATCH 6/8] arm: mach-armada: add support for Armada XP board
 with device tree
In-Reply-To: <20120515161655.504f1403@skate>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB25FE9.3060209@codethink.co.uk> <20120515161655.504f1403@skate>
Message-ID: <201205151425.30706.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 May 2012, Thomas Petazzoni wrote:
> Le Tue, 15 May 2012 14:53:45 +0100,
> Ben Dooks <ben.dooks@codethink.co.uk> a ?crit :
> 
> > Since the two board support files are identical, except for the names
> > they print, I'd say this is the job of one file. It can always be
> > split later.
> 
> The initial motivation for keeping two files here is that the two SoC
> have a different number of PCIe memory areas, and those areas are
> typically mapped in ->map_io(). However:
> 
>  * Maybe those mappings can be done using a normal ioremap() rather
>    than in ->map_io(), according to DT informations (but most other ARM
>    SoC support at the moment seem to do PCI mappings using static
>    mappings in ->map_io)

I'm pretty sure we can use ioremap for new PCI implementations now.
Also, you can scan the device tree in map_io() if necesary, to see which
PCIe ports are enabled.

	Arnd
