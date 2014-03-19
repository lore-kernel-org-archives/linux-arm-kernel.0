From: balbi@ti.com (Felipe Balbi)
Date: Wed, 19 Mar 2014 15:01:00 -0500
Subject: [PATCH 23/62] ARM: omap1: fix building without 32K_TIMER
In-Reply-To: <20140319195913.GA4271@saruman.home>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-24-git-send-email-arnd@arndb.de>
 <20140319195913.GA4271@saruman.home>
Message-ID: <20140319200100.GB4271@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 02:59:13PM -0500, Felipe Balbi wrote:
> Hi,
> 
> On Wed, Mar 19, 2014 at 08:29:20PM +0100, Arnd Bergmann wrote:
> > If we enable CONFIG_OMAP_MPU_TIMER and CONFIG_OMAP_DM_TIMER but
> > not CONFIG_OMAP_32K_TIMER on OMAP1, we currently get this build error:
> > 
> > mach-omap1/pm.c: In function 'omap1_pm_idle':
> > mach-omap1/pm.c:123:9: error: 'enable_dyn_sleep' undeclared (first use in this function)
> >   while (enable_dyn_sleep) {
> >          ^
> > mach-omap1/pm.c:123:9: note: each undeclared identifier is reported only once for each function it appears in
> > 
> > This attempts to fix the #ifdef logic to deal with all combinations
> > of timers.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: linux-omap at vger.kernel.org
> > Cc: Tony Lindgren <tony@atomide.com>
> 
> I had sent a fix for months and months ago, what happened to it ?

Here

http://marc.info/?l=linux-omap&m=138963632408031&w=2

Tony, did you forget to send a pull request ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140319/1f1a2926/attachment-0001.sig>
