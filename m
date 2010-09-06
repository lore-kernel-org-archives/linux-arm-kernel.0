From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 6 Sep 2010 12:30:26 +0200
Subject: A serial patchs that support FSL's eSDHC
In-Reply-To: <A88EF4D64D8447468743DC1503C0B6CA078545@zch01exm22.fsl.freescale.net>
References: <1283334305-12453-1-git-send-email-r65037@freescale.com>
	<20100901101500.GE11407@pengutronix.de>
	<A88EF4D64D8447468743DC1503C0B6CA078545@zch01exm22.fsl.freescale.net>
Message-ID: <20100906103026.GA2617@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

(going back to the list. A few more eyes during the process will surely
help :))

On Fri, Sep 03, 2010 at 06:26:05PM +0800, Zhu Richard-R65037 wrote:

> I encounter some problems when I merge my eSDHC driver into
> sdhci-pltfm.c driver.
> In the eSDHC solution there is a little complex in the driver
> implementation refer to the HW/IC design.
> One private struct such as sdhci_fsl_host in my original codes is
> needed, and the board specified platform data (such
>  as imxmmc_platform_data struct) is mandatory required too.
> 
> sdhci-pltfm.c driver can't provide such kinds of APIs.
> Do you have any suggestions?

Well, I think we can do without. In a few minutes, I will post an RFC
which I just hacked. Please have a look at it, and say if you have
comments or suggestions. Hopefully you'll agree that this approach is a
lot less intrusive. I will mainly concentrate on the driver. For the
platform part, Uwe already gave a few comments. I will also reply to
some of your patches to clarify some issues.

Regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100906/de6ef16d/attachment.sig>
