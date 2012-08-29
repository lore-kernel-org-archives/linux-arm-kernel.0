From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 29 Aug 2012 11:26:39 -0700
Subject: [PATCH V5 0/5] clk: mmp: add clock framework for mmp
In-Reply-To: <CADApbehotHB7JSCHdo_eoTb08C5Pe6ewh7whwckQTyuCcMM=BQ@mail.gmail.com>
References: <1345431315-8037-1-git-send-email-xiechao.mail@gmail.com>
 <20120825002151.18366.99434@nucleus>
 <CADApbehotHB7JSCHdo_eoTb08C5Pe6ewh7whwckQTyuCcMM=BQ@mail.gmail.com>
Message-ID: <20120829182639.4450.99900@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Chao Xie (2012-08-26 18:19:02)
> On Sat, Aug 25, 2012 at 8:21 AM, Mike Turquette <mturquette@linaro.org> wrote:
> > Quoting Chao Xie (2012-08-19 19:55:10)
> >> From: Chao Xie <chao.xie@marvell.com>
> >>  arch/arm/mach-mmp/Kconfig    |    3 +
> >>  drivers/clk/Makefile         |    3 +
> >>  drivers/clk/mmp/Makefile     |    9 +
> >>  drivers/clk/mmp/clk-apbc.c   |  152 ++++++++++++++
> >>  drivers/clk/mmp/clk-apmu.c   |   97 +++++++++
> >>  drivers/clk/mmp/clk-frac.c   |  153 ++++++++++++++
> >>  drivers/clk/mmp/clk-mmp2.c   |  449 ++++++++++++++++++++++++++++++++++++++++++
> >>  drivers/clk/mmp/clk-pxa168.c |  346 ++++++++++++++++++++++++++++++++
> >>  drivers/clk/mmp/clk-pxa910.c |  320 ++++++++++++++++++++++++++++++
> >>  drivers/clk/mmp/clk.h        |   35 ++++
> >
> > Looks like you are not removing your arch/arm/mach-mmp/clock.c.  Is that
> > intentional?
> >
> > When I apply your series against v3.6-rc3 I find that compilation breaks
> > with mmp2_defconfig due to conflicting definitions for the clk api
> > (clk_enable, clk_set_rate, etc).  This is not surprising since your
> > legacy clock code is neither deleted nor removed from compilation
> > conditionally by checking for CONFIG_COMMON_CLK.
> >
> > Did I somehow manage to misapply your patches or should your patches
> > have removed the arch-specific clock framework as well?
> >
> hi, Mike
> Yes. There are some patches for seperate the original clock code in arch.
> I had sent these patches before, but it seems that too many patches
> sent, and haojian missed it.
> I will sent out the patches for arch today. Thanks.
> 

I pulled in the dependency series and the build goes through nicely now.
I'm happy to take these five patches into clk-next but of course mmp
will have problems building clk-next without the dependencies, which I
assume are going through arm-soc.

Regards,
Mike

> > Regards,
> > Mike
> >
> >>  10 files changed, 1567 insertions(+), 0 deletions(-)
> >>  create mode 100644 drivers/clk/mmp/Makefile
> >>  create mode 100644 drivers/clk/mmp/clk-apbc.c
> >>  create mode 100644 drivers/clk/mmp/clk-apmu.c
> >>  create mode 100644 drivers/clk/mmp/clk-frac.c
> >>  create mode 100644 drivers/clk/mmp/clk-mmp2.c
> >>  create mode 100644 drivers/clk/mmp/clk-pxa168.c
> >>  create mode 100644 drivers/clk/mmp/clk-pxa910.c
> >>  create mode 100644 drivers/clk/mmp/clk.h
