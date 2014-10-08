From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 8 Oct 2014 11:50:05 +0100
Subject: [PATCH 8/9] mtd: nand: stm_nand_bch: add support for ST's BCH
 NAND controller
In-Reply-To: <20141006064030.GA20598@norris-Latitude-E6410>
References: <1409143344-22458-1-git-send-email-lee.jones@linaro.org>
 <1409143344-22458-9-git-send-email-lee.jones@linaro.org>
 <20141006064030.GA20598@norris-Latitude-E6410>
Message-ID: <20141008105005.GH20647@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 05 Oct 2014, Brian Norris wrote:

> On Wed, Aug 27, 2014 at 01:42:23PM +0100, Lee Jones wrote:
> > Reviewed-By: Pekon Gupta <pekon@pek-sem.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/mtd/nand/Kconfig        |    7 +
> >  drivers/mtd/nand/Makefile       |    1 +
> >  drivers/mtd/nand/stm_nand_bch.c | 1616 +++++++++++++++++++++++++++++++++++++++
> >  drivers/mtd/nand/stm_nand_dt.c  |  110 +++
> >  drivers/mtd/nand/stm_nand_dt.h  |   24 +
> >  include/linux/mtd/stm_nand.h    |  147 ++++
> >  6 files changed, 1905 insertions(+)
> >  create mode 100644 drivers/mtd/nand/stm_nand_bch.c
> >  create mode 100644 drivers/mtd/nand/stm_nand_dt.c
> >  create mode 100644 drivers/mtd/nand/stm_nand_dt.h
> >  create mode 100644 include/linux/mtd/stm_nand.h
> 
> One more thing: you never answered my question from [1]: 
> 
> Does your driver pass the MTD tests? (drivers/mtd/tests/)

It does.  Apart from the ones which insist on reading the OOB area,
which isn't allowed via the normal call-backs supplied.

> [1] http://lists.infradead.org/pipermail/linux-mtd/2014-August/055084.html

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
