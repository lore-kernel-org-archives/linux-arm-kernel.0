From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Tue, 11 Feb 2014 10:58:53 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MyAxLzJdIHNwaTpmc2wtZHNwaTpjb252ZXJ0IHRvIHVz?=
 =?UTF-8?B?ZSByZWdtYXAgYW5kIGJpZy1lbmRpYW4gc3VwcG9ydHM=?=
In-Reply-To: <1392097697-14919-1-git-send-email-b44548@freescale.com>
References: <1392097697-14919-1-git-send-email-b44548@freescale.com>
Message-ID: <1392101933.572206593@f147.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

???????, 11 ??????? 2014, 13:48 +08:00 ?? Chao Fu <b44548@freescale.com>:
> From: Chao Fu <B44548@freescale.com>
> 
> Freescale DSPI module will have two endianess in different platform,
> but ARM is little endian. So when DSPI in big endian, core in little endian,
> readl and writel can not adjust R/W register in this condition.
> This patch will remove general readl/writel, and import regmap mechanism.
> Data endian will be transfered in regmap APIs.

In this case You should additionally select REGMAP_MMIO option
for SPI_FSL_DSPI in the drivers/spi/Kconfig.

---
