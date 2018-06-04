From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Mon, 4 Jun 2018 09:08:11 +0900
Subject: [PATCH 6/8] media: uniphier: add common module of DVB adapter
 drivers
In-Reply-To: <CAK7LNAS8JT8+MAuH+eYUJ3Xa4r07=ecJS0E=SX-tgmV7db_FKw@mail.gmail.com>
References: <20180530090946.1635-1-suzuki.katsuhiro@socionext.com>
 <20180530090946.1635-7-suzuki.katsuhiro@socionext.com>
 <CAK7LNAS8JT8+MAuH+eYUJ3Xa4r07=ecJS0E=SX-tgmV7db_FKw@mail.gmail.com>
Message-ID: <005d01d3fb98$20711900$61534b00$@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Yamada-san,

> -----Original Message-----
> From: Masahiro Yamada <yamada.masahiro@socionext.com>
> Sent: Saturday, June 2, 2018 9:00 PM
> To: Suzuki, Katsuhiro/?? ?? <suzuki.katsuhiro@socionext.com>
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>;
> linux-media at vger.kernel.org; Masami Hiramatsu <masami.hiramatsu@linaro.org>;
> Jassi Brar <jaswinder.singh@linaro.org>; linux-arm-kernel
> <linux-arm-kernel@lists.infradead.org>; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 6/8] media: uniphier: add common module of DVB adapter drivers
> 
> 2018-05-30 18:09 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
> > This patch adds common module for UniPhier DVB adapter drivers
> > that equipments tuners and demod that connected by I2C and
> > UniPhier demux.
> >
> > Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> > ---
> >  drivers/media/platform/uniphier/Makefile      |  5 ++
> >  drivers/media/platform/uniphier/hsc-core.c    |  8 ---
> >  .../platform/uniphier/uniphier-adapter.c      | 54 +++++++++++++++++++
> >  .../platform/uniphier/uniphier-adapter.h      | 42 +++++++++++++++
> >  4 files changed, 101 insertions(+), 8 deletions(-)
> >  create mode 100644 drivers/media/platform/uniphier/uniphier-adapter.c
> >  create mode 100644 drivers/media/platform/uniphier/uniphier-adapter.h
> >
> > diff --git a/drivers/media/platform/uniphier/Makefile
> b/drivers/media/platform/uniphier/Makefile
> > index 0622f04d9e68..9e75ad081b77 100644
> > --- a/drivers/media/platform/uniphier/Makefile
> > +++ b/drivers/media/platform/uniphier/Makefile
> > @@ -3,3 +3,8 @@ uniphier-dvb-y += hsc-core.o hsc-ucode.o hsc-css.o hsc-ts.o
> hsc-dma.o
> >  uniphier-dvb-$(CONFIG_DVB_UNIPHIER_LD11) += hsc-ld11.o
> >
> >  obj-$(CONFIG_DVB_UNIPHIER) += uniphier-dvb.o
> > +
> > +ccflags-y += -Idrivers/media/dvb-frontends/
> > +ccflags-y += -Idrivers/media/tuners/
> 
> 
> Please add $(srctree)/ like
> 
> ccflags-y += -I$(srctree)/drivers/media/dvb-frontends/
> ccflags-y += -I$(srctree)/drivers/media/tuners/
> 
> 
> Currently, it works $(srctree)/,
> but I really want to rip off the build system hack.

Thanks, I agree with your opinion, but other Makefiles in drivers/media use 
same hack. I don't know other way to include headers of demodulators and 
tuners...

Do you have any good ideas?


Regards,
--
Katsuhiro Suzuki


> 
> 
> 
> 
> 
> --
> Best Regards
> Masahiro Yamada
