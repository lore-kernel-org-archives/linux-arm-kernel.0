From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 17 Aug 2010 10:54:06 +0200
Subject: [PATCH 1/3] mxc_nand: set spare size and pages per block
In-Reply-To: <80zkwm69uv.fsf@merkur.tec.linutronix.de>
References: <80r5i63dn4.fsf@merkur.tec.linutronix.de>
	<20100810121912.GG27749@pengutronix.de>
	<801va635f7.fsf@merkur.tec.linutronix.de>
	<20100811125625.GS27749@pengutronix.de>
	<80r5i5z3v1.fsf@merkur.tec.linutronix.de>
	<20100816112837.GO27749@pengutronix.de>
	<80zkwm69uv.fsf@merkur.tec.linutronix.de>
Message-ID: <20100817085406.GW27749@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 16, 2010 at 02:05:44PM +0200, John Ogness wrote:
> On 2010-08-16, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > Ok, here is an updated version of this patch
> >
> > Sascha
> >
> > commit 3a411e6c690654f78bea93dd8cdb14c27ba418a5
> > Author: Sascha Hauer <s.hauer@pengutronix.de>
> > Date:   Mon Aug 9 14:21:00 2010 +0200
> >
> >     mxc_nand: do not depend on disabling the irq in the interrupt handler
> >     
> >     This patch reverts the driver to enabling/disabling the NFC interrupt
> >     mask rather than enabling/disabling the system interrupt. This cleans
> >     up the driver so that it doesn't rely on interrupts being disabled
> >     within the interrupt handler.
> >     For i.MX21 we keep the current behaviour, that is calling
> >     enable_irq/disable_irq_nosync to enable/disable interrupts.
> >     This patch is based on earlier work by John Ogness.
> 
> Acked-by: John Ogness <john.ogness@linutronix.de>    

Can I consider this as an Acked-by for the whole series? And since you
tested it I would also add a tested-by. Here is a summary of the series
again:


The following changes since commit da5cabf80e2433131bf0ed8993abc0f7ea618c73:

  Linux 2.6.36-rc1 (2010-08-15 17:41:37 -0700)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git mxc-nand-pu

John Ogness (2):
      mxc_nand: Do not do byte accesses to the NFC buffer.
      mxc_nand: remove unused variables.

Sascha Hauer (10):
      mxc_nand: remove 0xe00 offset from registers
      mxc_nand: rework get_dev_status
      mxc_nand: make some internally used functions overwriteable
      mxc_nand: factor out a check_int function
      mxc_nand: add V1_V2 namespace to registers
      mxc_nand: support 8bit ecc
      mxc_nand: fix correct_data function
      mxc_nand: Add v3 (i.MX51) Support
      mxc_nand: do not depend on disabling the irq in the interrupt handler
      mxc_nand: configure pages per block for v2 controller

 drivers/mtd/nand/Kconfig    |    2 +-
 drivers/mtd/nand/mxc_nand.c |  671 +++++++++++++++++++++++++++++++++----------
 2 files changed, 521 insertions(+), 152 deletions(-)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
