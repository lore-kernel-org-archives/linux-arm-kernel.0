From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 26 Jan 2012 21:49:06 +0100
Subject: [PATCH] Added phy3250_defconfig
In-Reply-To: <4F217994.2080906@antcom.de>
References: <1327592865-16859-1-git-send-email-stigge@antcom.de>
 <4F217994.2080906@antcom.de>
Message-ID: <20120126204906.GB2600@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roland,

> We recently discussed that the first step for better LPC32XX integration
> would be a respective defconfig file.

Yes. Thanks for doing this.

> 
> With this patch (for Linux 3.3.0-rc1), I'm providing a phy3250_defconfig
> that especially supports the reference design by PHYTEC. This is because
> every supported board (including the PHY board) will have hardware
> specific parameters that don't map very good to a reasonably general
> lpc32xx_defconfig. Please tell me what you think about that.

I'd really like to see a lpc32xx_defconfig. We managed to have a
mxs_defconfig and are working to merge other imx defconfigs, too, for
example. If something prevents a lpc32xx_defconfig, we should probably
take a look and try to fix it.

Also, please use 'make save_defconfig' to shrink the size like all other
defconfigs have done.

> Some further notes:
> 
> * I added LPC3XXX to mach-types because the bootloader on my PHY3250
> board identifies as machine type no. 736.

Then the bootloader is wrong :) The board has 2511.

> * This is a minimal patch that makes lpc32xx compile and boot. I will
> submit further drivers for LPC32xx building upon that.

Those should be seperate. First the fixes, then the defconfig.

> * OHCI HCD is currently broken, disabled for now (already have a newer
> one working, will submit later)

That's OK.

> * The previously discussed update for clock.c will also follow in a
> separate patch (currently compiles with several warnings).

If not too much work, would be great to have this in the series as well.

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120126/6ae64300/attachment.sig>
