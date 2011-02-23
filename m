From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Feb 2011 13:09:52 +0000
Subject: [PATCH v2 01/13] mfd: pruss mfd driver.
In-Reply-To: <20110222103127.GC30279@sortiz-mobl>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
	<1297435892-28278-2-git-send-email-subhasish@mistralsolutions.com>
	<20110221163027.GF10686@sortiz-mobl>
	<37B3755C4AE64BAA805DFBAEBDC3D9E4@subhasishg>
	<20110222103127.GC30279@sortiz-mobl>
Message-ID: <20110223130952.GJ29559@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 22, 2011 at 11:31:27AM +0100, Samuel Ortiz wrote:
> So, if you have a:
> 
> static u32 reg_offset(struct device *dev, u8 pru_num)
> {
> 	struct da8xx_pruss *pru = dev_get_drvdata(dev->parent);
> 
> 	switch (pru_num) {
> 	case DA8XX_PRUCORE_0:
> 		return (u32) pru->ioaddr + 0x7000;
> 	case DA8XX_PRUCORE_1:
> 		return (u32) pru->ioaddr + 0x7800;
> 	default:
> 		return 0;
> }

No.  Please don't encourage people to have 'u32' as valid cookies for
readl,writel et.al.  Always make the mmio cookies __iomem pointer like.
