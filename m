From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 7 Apr 2014 12:08:41 +0100
Subject: [PATCH v6 01/36] mtd: st_spi_fsm: Allocate resources and
 register with MTD framework
In-Reply-To: <1396863705.8506.39.camel@x220>
References: <1395307268-12721-1-git-send-email-lee.jones@linaro.org>
 <1395307268-12721-2-git-send-email-lee.jones@linaro.org>
 <1396858351.8506.8.camel@x220> <20140407091110.GB8888@lee--X1>
 <1396863705.8506.39.camel@x220>
Message-ID: <20140407110841.GC8888@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
> > > > index 0128138..1210bc2 100644
> > > > --- a/drivers/mtd/devices/Kconfig
> > > > +++ b/drivers/mtd/devices/Kconfig
> > > > @@ -210,6 +210,14 @@ config MTD_DOCG3
> > > >  	  M-Systems and now Sandisk. The support is very experimental,
> > > >  	  and doesn't give access to any write operations.
> > > >  
> > > > +config MTD_ST_SPI_FSM
> > > > +	tristate "ST Microelectronics SPI FSM Serial Flash Controller"
> > > > +	depends on ARM || SH
> > > 
> > > That should probably be
> > >           depends on ARM || SUPERH
> > 
> > Actually it should be ARCH_STI, but thanks for the prompt.
> 
> I wouldn't have guessed that!
> 
> (Is ARCH_STI actually needed? ARCH_STI doesn't formally depend on ARM
> but I don't think one can end up with a .config with ARCH_STI set
> without ARM also set. Or am I mistaken?)

Sorry Paul, I should have been clearer. The line should read:

      depends on ARCH_STI

> > > > +	help
> > > > +	  This provides an MTD device driver for the ST Microelectronics
> > > > +	  SPI Fast Sequence Mode (FSM) Serial Flash Controller and support
> > > > +	  for a subset of connected Serial Flash devices.
> > > > +
> > > >  if MTD_DOCG3
> > > >  config BCH_CONST_M
> > > >  	default 14
> > > 
> > > Can this still be fixed in a future version of this series or should I
> > > send a trivial patch?
> > 
> > Do you mean the SH thing, or are you now referencing something else?
> > 
> > If the former then I'm happy to send a fixup patch.
> 
> No, I was talking about the SH symbol. I'll gladly leave it up to you to
> fix this.

No problem, ta.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
