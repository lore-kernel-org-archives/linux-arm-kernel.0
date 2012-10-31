From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 31 Oct 2012 00:05:36 +0000 (UTC)
Subject: [PATCH 09/11] ARM: OMAP: Fix relative includes for debug-devices.h
In-Reply-To: <20121030235300.25936.9859.stgit@muffinssi.local>
References: <20121030234852.25936.12482.stgit@muffinssi.local>
 <20121030235300.25936.9859.stgit@muffinssi.local>
Message-ID: <alpine.DEB.2.00.1210310003450.8340@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 30 Oct 2012, Tony Lindgren wrote:

> As discussed on linux-arm-kernel, we want to avoid
> relative includes for the arch/arm/*omap* shared code:
> 
> http://www.spinics.net/lists/linux-omap/msg80520.html
> 
> Let's add plat/debug-devices.h for debug_card_init()
> to fix the relative includes.
> 
> Note that drivers must not use this header as it will
> break build for omap2+ CONFIG_MULTIPLATFORM builds.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Looks fine to me; the original patch didn't use relative include paths.  
At some point the debug card device code should be moved into drivers/ as 
we discussed...


- Paul
