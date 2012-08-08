From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 8 Aug 2012 22:41:51 +0800
Subject: [PATCH 1/6] ARM: mxs: tx28: reset fec phy for device tree boot
In-Reply-To: <201208071915.26932.arnd@arndb.de>
References: <1344267769-31166-1-git-send-email-shawn.guo@linaro.org>
 <1344267769-31166-2-git-send-email-shawn.guo@linaro.org>
 <201208071915.26932.arnd@arndb.de>
Message-ID: <20120808144148.GC14718@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2012 at 07:15:25PM +0000, Arnd Bergmann wrote:
> > +       /* Power up fec phy */
> > +       gpio_set_value(TX28_FEC_PHY_POWER, 1);
> > +       mdelay(26); /* 25ms according to data sheet */
> 
> 26 ms is a long time for a delay. I think you should use msleep here.
> 
I copied this from TX28 board file.  But I just changed it per your
comment.  Thanks.

-- 
Regards,
Shawn
