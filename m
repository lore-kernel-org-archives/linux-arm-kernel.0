From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 20 Mar 2014 16:07:04 +0100
Subject: [PATCH 3/4] ata: add new-style AHCI platform driver for DaVinci
 DA850 AHCI controller
In-Reply-To: <2662651.GJX9HVKij5@amdc1032>
References: <1395081118-15248-1-git-send-email-b.zolnierkie@samsung.com>
 <532AA2B0.1060103@ti.com> <2662651.GJX9HVKij5@amdc1032>
Message-ID: <348852006.YgTlFegqas@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, March 20, 2014 01:57:10 PM Bartlomiej Zolnierkiewicz wrote:

> > > +#define DA8XX_SYSCFG1_VIRT(x)	(da8xx_syscfg1_base + (x))
> > > +#define DA8XX_PWRDN_REG		0x18
> > > +
> > > +/* SATA PHY Control Register offset from AHCI base */
> > > +#define SATA_P0PHYCR_REG	0x178
> > > +
> > > +#define SATA_PHY_MPY(x)		((x) << 0)
> > > +#define SATA_PHY_LOS(x)		((x) << 6)
> > > +#define SATA_PHY_RXCDR(x)	((x) << 10)
> > > +#define SATA_PHY_RXEQ(x)	((x) << 13)
> > > +#define SATA_PHY_TXSWING(x)	((x) << 19)
> > > +#define SATA_PHY_ENPLL(x)	((x) << 31)
> > 
> > These can be replaced with BIT(N)
> 
> OK, I'll fix it.

Uh, no, we can't use BIT() here.

BIT(N) does (1UL << (N)) and here we have ((N) << offset).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
