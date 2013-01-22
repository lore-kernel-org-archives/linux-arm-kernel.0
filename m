From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 22 Jan 2013 09:30:13 -0800
Subject: [PATCH 15/15] staging/omapdrm: don't build on multiplatform
In-Reply-To: <50FEC508.50004@ti.com>
References: <1358788568-11137-1-git-send-email-arnd@arndb.de>
 <1358788568-11137-16-git-send-email-arnd@arndb.de>
 <50FD7A5F.9020702@ti.com> <201301211741.11875.arnd@arndb.de>
 <50FD8B63.1060506@ti.com> <20130122165330.GA28152@kroah.com>
 <50FEC508.50004@ti.com>
Message-ID: <20130122173013.GA17212@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 22, 2013 at 10:57:44AM -0600, Rob Clark wrote:
> On 01/22/2013 10:53 AM, Greg Kroah-Hartman wrote:
> >On Mon, Jan 21, 2013 at 12:39:31PM -0600, Rob Clark wrote:
> >>On 01/21/2013 11:41 AM, Arnd Bergmann wrote:
> >>>On Monday 21 January 2013, Rob Clark wrote:
> >>>>Are you sure OMAP2_DSS requires ARCH_OMAP2PLUS?  I don't see this, and
> >>>>it at least used to not depend on ARCH_OMAP2PLUS.  If it does now, I
> >>>>think the correct fix would be to remove the dependency in OMAP2_DSS.  I
> >>>>don't think removing ARCH_MULTIPLATFORM support in omapdrm is the
> >>>>correct solution.
> >>>At least it says so in drivers/video/omap2/Kconfig, which contains
> >>>
> >>>if ARCH_OMAP2PLUS
> >>>source drivers/video/omap2/dss/Kconfig
> >>>endif
> >>ahh, ok, I see.. the if ARCH_OMAP2PLUS bit looks like it came in
> >>recently (770b6cb)
> >>
> >>what about changing this to 'if ARCH_OMAP2PLUS || ARCH_MULTIPLATFORM'?
> >That's what Arnd's patch did.
> 
> sorry, I was talking about in drivers/video/omap2/Kconfig

Ah, ok.

> Ie. I'd prefer to re-enable omapdss on multi-plat rather than
> disabling omapdrm.  With changes in drm core, it is a bit of a pain
> to compile test all the arm drivers by doing N different builds, so
> we've been trying to get to the point of all arm drm drivers
> supporting multi-plat

Ok, I'll let you and Arnd fight it out and drop this patch from my
to-apply queue for now...

greg k-h
