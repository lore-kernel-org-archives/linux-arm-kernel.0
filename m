From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 12 Oct 2012 13:01:39 +0200
Subject: [PATCH 1/6] ARM: bcm476x: Add infrastructure
In-Reply-To: <201210121048.24998.arnd@arndb.de>
References: <20121007015300.828366635@gmail.com>
 <201210120803.54539.arnd@arndb.de> <20121012101252.6c3b7dce@skate>
 <201210121048.24998.arnd@arndb.de>
Message-ID: <20121012130139.6c3079c5@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Fri, 12 Oct 2012 10:48:24 +0000, Arnd Bergmann wrote:

> The main thing to watch out for are mappings that are not for MMIO,
> such as the call to create_mapping() in map_lowmem() or in
> devicemaps_init().
> 
> I would suggest making struct map_desc specific to callers of
> iotable_init() and changing the prototype for create_mapping() to
> 
> void __init create_mapping(unsigned long virtual, unsigned long pfn,
> 			   size_t length, unsigned int type);

Yes, this is exactly what I've done. I'll rebase my work, test and send
it.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
