From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 31 Oct 2011 01:39:34 +0200
Subject: [GIT PULL] pending DT patches and cleanup for map_io for v3.2
	merge window
In-Reply-To: <20111024091704.GF31337@atomide.com>
References: <20111024091704.GF31337@atomide.com>
Message-ID: <201110310039.34717.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 October 2011, Tony Lindgren wrote:
> As discussed in the ARM kernel meeting yesterday, here's are
> the pending omap things to pull for v3.2 merge window.

Hi Tony,

I finally got to pull these.

> These would be nice to get still in as other people's work
> such as Nico's map_io changes need #2 below.
> 
> 1. Initial DT support posted few weeks ago
> 
>    Please see the earlier pull request at:
> 
>    http://lkml.org/lkml/2011/10/4/441

Looks good. I've missed this initially because I had not yet managed
to go through that mail thread (randconfig patches) again and pick
up the patches that got an Ack. The pull request was right in the
middle of 100 other unread emails...

> 2. Cleanup for map_io posted few weeks ago
> 
>    This depends on the #1 above, and also requires
>    the ioremap_exec patch. Russell said he has applied
>    into devel-stable (But not pushed out yet?).
> 
>    When you have the ioremap_exec patch from Russell,
>    please pull this from:
> 
>    git://github.com/tmlind/linux.git sram-map-io
> 
>    Pull request against #1 attached below.

This had systematic but trivial conflicts against the memory.h
series, which I fixed up. There was also a conflict with 009426a0e
"ARM: omap: Setup consistent dma size at boot time" from Tixy.
That patch added a call to omap_init_consistent_dma_size in a function
that you removed. I have resolved the conflict by adding that call to
omap1_init_early and omap_common_init_early, but I have no idea if that
is a correct resolution. Please check.

	Arnd

	Arnd
