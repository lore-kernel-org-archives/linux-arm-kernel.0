From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 1 Sep 2010 12:15:00 +0200
Subject: A serial patchs that support FSL's eSDHC
In-Reply-To: <1283334305-12453-1-git-send-email-r65037@freescale.com>
References: <1283334305-12453-1-git-send-email-r65037@freescale.com>
Message-ID: <20100901101500.GE11407@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 01, 2010 at 05:45:04PM +0800, Richard Zhu wrote:

> Can you help me to review the following serial patchs, that enable the sdhci 
> driver to support FSL's eSDHC on i.MX family.

I see two major problems: First, you often modify sdhci.c to work around
the hardware-quirks. See sdhci-of-esdhc.c how it can be handled in a
seperate source-file and keep sdhci.c clean. (While at it, what is
common between the of-driver and the platform-driver should be shared).
Second, your platform-driver is a complete one, but we have a platform
core meanwhile (sdhci-pltfm.c). Please use that.

Kind regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100901/3451cf26/attachment.sig>
