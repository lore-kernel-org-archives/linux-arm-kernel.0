From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 15 May 2012 16:16:55 +0200
Subject: [PATCH 6/8] arm: mach-armada: add support for Armada XP board
 with device tree
In-Reply-To: <4FB25FE9.3060209@codethink.co.uk>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1337072084-21967-7-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB228AD.5000507@codethink.co.uk> <4FB25A9A.3070306@gmail.com>
 <4FB25FE9.3060209@codethink.co.uk>
Message-ID: <20120515161655.504f1403@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 15 May 2012 14:53:45 +0100,
Ben Dooks <ben.dooks@codethink.co.uk> a ?crit :

> Since the two board support files are identical, except for the names
> they print, I'd say this is the job of one file. It can always be
> split later.

The initial motivation for keeping two files here is that the two SoC
have a different number of PCIe memory areas, and those areas are
typically mapped in ->map_io(). However:

 * Maybe those mappings can be done using a normal ioremap() rather
   than in ->map_io(), according to DT informations (but most other ARM
   SoC support at the moment seem to do PCI mappings using static
   mappings in ->map_io)

 * We probably shouldn't have anticipated this too much, and keep only
   one file for this initial submission.

We'll rework this for our v2.

Thanks for the comments!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
