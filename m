From: david.lanzendoerfer@o2s.ch (David =?ISO-8859-1?Q?Lanzend=F6rfer?=)
Date: Wed, 05 Feb 2014 14:33:56 +0100
Subject: [PATCH 1/5] ARM: sunxi: Add driver for SD/MMC hosts found on
 Allwinner sunxi SoCs
In-Reply-To: <20131215134415.GE3651@lukather>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com>
 <1387058295-20641-2-git-send-email-hdegoede@redhat.com>
 <20131215134415.GE3651@lukather>
Message-ID: <1929408.6EF83UbB9S@dizzy-6.o2s.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
> I'm not that fond of these "default y" patterns. It forces the driver
> down to every user of the multiplatform kernels. I'd suggest removing
> the default and adding the driver to the defconfigs we have.
Ok. Removed it.

> > +static void sunxi_mmc_init_host(struct mmc_host *mmc)
> > +{
> > [...]
> > +	mci_writel(smc_host, REG_FUNS, 0xceaa0000);
> > +	mci_writel(smc_host, REG_DLBA, smc_host->sg_dma);
> I suppose we have no idea what these magics are all about ? :(
That's the parameters I could extract from the Chinese code.
Without proper documentation it will always stay magic what exactly these
values are meaning.

> > +#define mci_readl(host, reg) \
> > +	__raw_readl((host)->reg_base + SDXC_##reg)
> > +#define mci_writel(host, reg, value) \
> > +	__raw_writel((value), (host)->reg_base + SDXC_##reg)
> No barriers ? :(
Fixed that...

cheers
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140205/13e73392/attachment-0001.sig>
