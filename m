From: john.ogness@linutronix.de (John Ogness)
Date: Tue, 17 Aug 2010 19:02:02 +0200
Subject: [PATCH 1/3] mxc_nand: set spare size and pages per block
In-Reply-To: <20100817085406.GW27749@pengutronix.de> (Sascha Hauer's message
	of "Tue, 17 Aug 2010 10:54:06 +0200")
References: <80r5i63dn4.fsf@merkur.tec.linutronix.de>
	<20100810121912.GG27749@pengutronix.de>
	<801va635f7.fsf@merkur.tec.linutronix.de>
	<20100811125625.GS27749@pengutronix.de>
	<80r5i5z3v1.fsf@merkur.tec.linutronix.de>
	<20100816112837.GO27749@pengutronix.de>
	<80zkwm69uv.fsf@merkur.tec.linutronix.de>
	<20100817085406.GW27749@pengutronix.de>
Message-ID: <801v9x41h1.fsf@merkur.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2010-08-17, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> The following changes since commit da5cabf80e2433131bf0ed8993abc0f7ea618c73:
>
>   Linux 2.6.36-rc1 (2010-08-15 17:41:37 -0700)
>
> are available in the git repository at:
>   git://git.pengutronix.de/git/imx/linux-2.6.git mxc-nand-pu
>
> John Ogness (2):
>       mxc_nand: Do not do byte accesses to the NFC buffer.
>       mxc_nand: remove unused variables.
>
> Sascha Hauer (10):
>       mxc_nand: remove 0xe00 offset from registers
>       mxc_nand: rework get_dev_status
>       mxc_nand: make some internally used functions overwriteable
>       mxc_nand: factor out a check_int function
>       mxc_nand: add V1_V2 namespace to registers
>       mxc_nand: support 8bit ecc
>       mxc_nand: fix correct_data function
>       mxc_nand: Add v3 (i.MX51) Support
>       mxc_nand: do not depend on disabling the irq in the interrupt handler
>       mxc_nand: configure pages per block for v2 controller
>
>  drivers/mtd/nand/Kconfig    |    2 +-
>  drivers/mtd/nand/mxc_nand.c |  671 +++++++++++++++++++++++++++++++++----------
>  2 files changed, 521 insertions(+), 152 deletions(-)

Acked-by: John Ogness <john.ogness@linutronix.de>
Tested-by: John Ogness <john.ogness@linutronix.de>

I tested the driver with all the above changes on an i.MX35 with a
16-bit NAND chip. The driver performed as expected.
