From: tony@atomide.com (Tony Lindgren)
Date: Fri, 16 Dec 2016 09:11:30 -0800
Subject: [PATCH] omap2: mark omap_init_rng as __init
In-Reply-To: <20161216090906.2313595-1-arnd@arndb.de>
References: <20161216090906.2313595-1-arnd@arndb.de>
Message-ID: <20161216171130.GH4920@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [161216 01:10]:
> I found this section mismatch when building with an older
> compiler release:
> 
> WARNING: vmlinux.o(.text+0x3051c): Section mismatch in reference from the function omap_init_rng() to the function .init.text:omap_device_build()
> 
> Obviously this one function should be __init as well. Normally
> we don't get a warning as the function gets inlined into its
> caller.

Acked-by: Tony Lindgren <tony@atomide.com>
