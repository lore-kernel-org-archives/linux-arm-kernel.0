From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 07 Apr 2014 11:41:45 +0200
Subject: [PATCH v6 01/36] mtd: st_spi_fsm: Allocate resources and
 register with MTD framework
In-Reply-To: <20140407091110.GB8888@lee--X1>
References: <1395307268-12721-1-git-send-email-lee.jones@linaro.org>
 <1395307268-12721-2-git-send-email-lee.jones@linaro.org>
 <1396858351.8506.8.camel@x220> <20140407091110.GB8888@lee--X1>
Message-ID: <1396863705.8506.39.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-04-07 at 10:11 +0100, Lee Jones wrote:
> > > diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
> > > index 0128138..1210bc2 100644
> > > --- a/drivers/mtd/devices/Kconfig
> > > +++ b/drivers/mtd/devices/Kconfig
> > > @@ -210,6 +210,14 @@ config MTD_DOCG3
> > >  	  M-Systems and now Sandisk. The support is very experimental,
> > >  	  and doesn't give access to any write operations.
> > >  
> > > +config MTD_ST_SPI_FSM
> > > +	tristate "ST Microelectronics SPI FSM Serial Flash Controller"
> > > +	depends on ARM || SH
> > 
> > That should probably be
> >           depends on ARM || SUPERH
> 
> Actually it should be ARCH_STI, but thanks for the prompt.

I wouldn't have guessed that!

(Is ARCH_STI actually needed? ARCH_STI doesn't formally depend on ARM
but I don't think one can end up with a .config with ARCH_STI set
without ARM also set. Or am I mistaken?)

> > > +	help
> > > +	  This provides an MTD device driver for the ST Microelectronics
> > > +	  SPI Fast Sequence Mode (FSM) Serial Flash Controller and support
> > > +	  for a subset of connected Serial Flash devices.
> > > +
> > >  if MTD_DOCG3
> > >  config BCH_CONST_M
> > >  	default 14
> > 
> > Can this still be fixed in a future version of this series or should I
> > send a trivial patch?
> 
> Do you mean the SH thing, or are you now referencing something else?
> 
> If the former then I'm happy to send a fixup patch.

No, I was talking about the SH symbol. I'll gladly leave it up to you to
fix this.


Paul Bolle
