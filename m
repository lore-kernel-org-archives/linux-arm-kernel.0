From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Mar 2012 16:03:12 +0000
Subject: [PATCH 0/3] introduce stmp-style devices
In-Reply-To: <1331159314-12022-1-git-send-email-w.sang@pengutronix.de>
References: <1331159314-12022-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <201203081603.12817.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 March 2012, Wolfram Sang wrote:
> 
> This series makes support for a certain type of devices mach independant. We
> want that because such devices (having a special register layout) have been
> found in mach-mxs and mach-mx6 meanwhile. Please refer to patch 1/3 for a more
> detailed description.
> 
> Patch 1/3 adds the basic support and is of main interest to get upstream.
> Patches 2/3 and 3/3 are usage examples and will be send to the relevant
> subsystems once the basic support is accepted.
> 
> Main changes since the RFC:
> 
> * renamed the macros to STMP_OFFSET_*
> * rebased to 3.3-rc6
> 
> Tested with a TX28 board.

I think having the stmp_device code is good, but I'm not sure about the
location in drivers/base, which is otherwise reserved for anything related
to 'struct device'. How about putting the same file into lib/stmpregs.c?

	Arnd
