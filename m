From: linuxzsc@gmail.com (Richard Zhao)
Date: Mon, 21 Feb 2011 20:26:27 +0800
Subject: [PATCH 5/5] mmc: sdhci: add quirk
	SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO
In-Reply-To: <20110221110624.GK14495@n2100.arm.linux.org.uk>
References: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com>
	<1298282095-2279-5-git-send-email-richard.zhao@freescale.com>
	<20110221110624.GK14495@n2100.arm.linux.org.uk>
Message-ID: <20110221122627.GA2043@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 11:06:24AM +0000, Russell King - ARM Linux wrote:
> On Mon, Feb 21, 2011 at 05:54:55PM +0800, Richard Zhao wrote:
> > +	if (host->quirks & SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO) {
> > +		if (readl(host->ioaddr + SDHCI_VENDOR_SPEC) & 0x2)
> > +			writel(readl(host->ioaddr + SDHCI_VENDOR_SPEC) & ~0x2,
> > +					host->ioaddr + SDHCI_VENDOR_SPEC);
> 
> Is it necessary to read the register twice, or would:
> 
> 		u32 val = readl(host->ioaddr + SDHCI_VENDOR_SPEC);
> 		if (val & 0x02)
> 			writel(val & ~0x02, host->ioaddr + SDHCI_VENDOR_SPEC);
> 
> be clearer and more obvious?
correct. Thanks.

Richard
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
