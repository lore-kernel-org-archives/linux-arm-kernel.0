From: tony@atomide.com (Tony Lindgren)
Date: Mon, 3 Oct 2011 11:03:06 -0700
Subject: [PATCH 11/30] ARM: omap2/n8x0: work around modular omap mmc
In-Reply-To: <1412062.DNcqS3fczZ@wuerfel>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-12-git-send-email-arnd@arndb.de>
	<20111002155331.GA12323@n2100.arm.linux.org.uk>
	<1412062.DNcqS3fczZ@wuerfel>
Message-ID: <20111003180305.GV6324@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [111002 11:22]:
> On Sunday 02 October 2011 16:53:31 Russell King - ARM Linux wrote:
> > On Sun, Oct 02, 2011 at 04:45:41PM +0200, Arnd Bergmann wrote:
> > > -#if defined(CONFIG_MENELAUS) &&                                              \
> > > -     (defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE))
> > > +#if defined(CONFIG_MENELAUS) && defined(CONFIG_MMC_OMAP)
> > > +/* || defined(CONFIG_MMC_OMAP_MODULE)) */
> > > +/* FIXME: cannot call omap_mmc_notify_cover_event for ONFIG_MMC_OMAP_MODULE */
> > 
> > #ifdef CONFIG_MMC_OMAP_MODULE
> > #warning FIXME: cannot call omap_mmc_notify_cover_event for CONFIG_MMC_OMAP_MODULE
> > #endif
> > #if defined(CONFIG_MENELAUS) && defined(CONFIG_MMC_OMAP)
> > 
> > So that it can be seen at build time?
> > 
> > Also note the 'ONFIG' typo...
> 
> Ok, good idea. I've updated the patch in the git tree accordingly.

Acked-by: Tony Lindgren <tony@atomide.com>
 
> Depending on what Tony wants, I might send out the entire series
> again once there are no more new comments.

Up to you, I usually prefer to see just updated patches as long
as the mail thread stays readable.

Regards,

Tony
