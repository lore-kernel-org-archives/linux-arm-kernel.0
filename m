From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 7 Apr 2014 10:11:10 +0100
Subject: [PATCH v6 01/36] mtd: st_spi_fsm: Allocate resources and
 register with MTD framework
In-Reply-To: <1396858351.8506.8.camel@x220>
References: <1395307268-12721-1-git-send-email-lee.jones@linaro.org>
 <1395307268-12721-2-git-send-email-lee.jones@linaro.org>
 <1396858351.8506.8.camel@x220>
Message-ID: <20140407091110.GB8888@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > This is a new driver. It's used to communicate with a special type of
> > optimised Serial Flash Controller called the FSM. The FSM uses a subset
> > of the SPI protocol to communicate with supported NOR-Flash devices.
> > 
> > Acked-by Angus Clark <angus.clark@st.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> This patch seems to be commit d90db4a07429 ("mtd: st_spi_fsm: Allocate
> resources and register with MTD framework") in current linux-next. 
> 
> > ---
> >  drivers/mtd/devices/Kconfig      |   8 +++
> >  drivers/mtd/devices/Makefile     |   1 +
> >  drivers/mtd/devices/st_spi_fsm.c | 106 +++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 115 insertions(+)
> >  create mode 100644 drivers/mtd/devices/st_spi_fsm.c
> > 
> > diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
> > index 0128138..1210bc2 100644
> > --- a/drivers/mtd/devices/Kconfig
> > +++ b/drivers/mtd/devices/Kconfig
> > @@ -210,6 +210,14 @@ config MTD_DOCG3
> >  	  M-Systems and now Sandisk. The support is very experimental,
> >  	  and doesn't give access to any write operations.
> >  
> > +config MTD_ST_SPI_FSM
> > +	tristate "ST Microelectronics SPI FSM Serial Flash Controller"
> > +	depends on ARM || SH
> 
> That should probably be
>           depends on ARM || SUPERH

Actually it should be ARCH_STI, but thanks for the prompt.

> > +	help
> > +	  This provides an MTD device driver for the ST Microelectronics
> > +	  SPI Fast Sequence Mode (FSM) Serial Flash Controller and support
> > +	  for a subset of connected Serial Flash devices.
> > +
> >  if MTD_DOCG3
> >  config BCH_CONST_M
> >  	default 14
> 
> Can this still be fixed in a future version of this series or should I
> send a trivial patch?

Do you mean the SH thing, or are you now referencing something else?

If the former then I'm happy to send a fixup patch.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
