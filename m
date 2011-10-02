From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 2 Oct 2011 16:53:31 +0100
Subject: [PATCH 11/30] ARM: omap2/n8x0: work around modular omap mmc
In-Reply-To: <1317566760-25681-12-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-12-git-send-email-arnd@arndb.de>
Message-ID: <20111002155331.GA12323@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 02, 2011 at 04:45:41PM +0200, Arnd Bergmann wrote:
> -#if defined(CONFIG_MENELAUS) &&						\
> -	(defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE))
> +#if defined(CONFIG_MENELAUS) && defined(CONFIG_MMC_OMAP)
> +/* || defined(CONFIG_MMC_OMAP_MODULE)) */
> +/* FIXME: cannot call omap_mmc_notify_cover_event for ONFIG_MMC_OMAP_MODULE */

#ifdef CONFIG_MMC_OMAP_MODULE
#warning FIXME: cannot call omap_mmc_notify_cover_event for CONFIG_MMC_OMAP_MODULE
#endif
#if defined(CONFIG_MENELAUS) && defined(CONFIG_MMC_OMAP)

So that it can be seen at build time?

Also note the 'ONFIG' typo...
