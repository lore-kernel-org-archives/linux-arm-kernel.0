From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Nov 2012 13:00:45 +0000
Subject: [GIT PULL][for 3.8] pull request from upload/board in arch-pxa
 git tree
In-Reply-To: <50991FF6.8070709@yahoo.com>
References: <CAN1soZzhb361Gs9JVmhkjqqcr6FkGg9MVO_n9Tv29F==HdhwQQ@mail.gmail.com>
 <20121106140051.GB27284@quad.lixom.net> <50991FF6.8070709@yahoo.com>
Message-ID: <201211151300.45323.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 November 2012, Paul Parsons wrote:
> On 06/11/12 14:00, Olof Johansson wrote:
> > On Sun, Oct 28, 2012 at 07:59:54AM +0800, Haojian Zhuang wrote:
> >> ----------------------------------------------------------------
> >> Paul Parsons (1):
> >>        ARM: pxa2xx: Remove EXPERIMENTAL dependency from spi-pxa2xx driver
> >
> > This is a SPI driver change, and should either go through or be acked by that
> > maintainer. In this particular case, there's been several series of the
> > EXPERIMENTAL removals, and I think Kees Cook has one that removes it for all
> > options in one go. So please ack that patch instead.
> 
> According to the current MAINTAINERS file, the drivers/spi/spi-pxa2xx*
> driver is maintained by the PXA2xx/PXA3xx guys.
> That is why I submitted this patch to the linux-arm-kernel list.
> Is the MAINTAINERS file incorrect?

The file is correct, but it's not always easy to understand. drivers/spi
overall is maintained by Grant, which arch/arm/mach-* is maintained by
Olof and me. Haojian maintains the PXA components for each one, so the
formal way to do this is to have arch/arm/mach-pxa patches go

Author -> Haojian -> arm-soc -> Torvalds

while drivers/spi/spi-pxa* change go

Author -> Haojian -> Grant -> Torvalds

In some cases, you need extra knowledge that is not documented properly,
e.g. that Grant was on leave recently, and Mark Brown stepped in for
him, or that the arm-soc maintainership has not been documented at
all for some time (fixed now). In doubt, just add more people to Cc.
We're all good at ignoring email that doesn't seem to address us ;-)

	Arnd
