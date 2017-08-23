From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Aug 2017 07:53:29 -0700
Subject: [PATCH] ARM: OMAP2+: fix missing variable declaration
In-Reply-To: <12875092.dy1RW0XmqV@avalon>
References: <20170823132841.642239-1-arnd@arndb.de>
 <12875092.dy1RW0XmqV@avalon>
Message-ID: <20170823145328.GN6008@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [170823 06:53]:
> Hi Arnd,
> 
> On Wednesday, 23 August 2017 16:28:19 EEST Arnd Bergmann wrote:
> > The function that was added doesn't actually build:
> > 
> > arch/arm/mach-omap2/display.c: In function 'omapdss_init_fbdev':
> > arch/arm/mach-omap2/display.c:184:2: error: 'r' undeclared (first use in
> > this function)
> > 
> > This adds a declaration for 'r' to fix it.
> > 
> > Fixes: 5ce783025c82 ("ARM: OMAP2+: Don't register omapdss device for
> > omapdrm")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Looks like I haven't tested the patch with CONFIG_FB_OMAP2 enabled after the 
> last rebase. I'm very sorry about that :-(
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Tomi, I assume you will pick this up and sent it to Dave for v4.14-rc1.

Acked-by: Tony Lindgren <tony@atomide.com>
