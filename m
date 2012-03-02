From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 2 Mar 2012 20:02:59 +0000
Subject: [PATCH 5/5 v2] ARM: kirkwood: convert orion-wdt to fdt.
In-Reply-To: <20120302195710.GP11986@titan.lakedaemon.net>
References: <cover.1330709314.git.jason@lakedaemon.net>
 <201203021832.34901.arnd@arndb.de>
 <20120302195710.GP11986@titan.lakedaemon.net>
Message-ID: <201203022003.08756.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 March 2012, Jason wrote:
> On Fri, Mar 02, 2012 at 06:32:33PM +0000, Arnd Bergmann wrote:
>
> > As I commented before, I think the best approach would be to
> > provide a hardcoded resource for the device in the legacy case
> > and just use platform_get_resource() to get the resource
> > and ioremap it in either case.
> 
> Sorry, my denseness got in the way.  When you said hardcoded, I thought
> you meant #define TIMER_VIRT_BASE .

Using TIMER_VIRT_BASE wouldn't be all that wrong either, but I think it's
better to use the same code path in both ways. Using a resource also has
the nice side-effect of allowing us to build a multiplatform kernel for
anything that uses orion-wdt but has different constants for TIMER_VIRT_BASE.

	Arnd
