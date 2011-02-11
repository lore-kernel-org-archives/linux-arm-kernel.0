From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 12 Feb 2011 06:08:23 +0800
Subject: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
In-Reply-To: <19794.17994.381937.158944@ipc1.ka-ro>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
	<1296872327-21166-2-git-send-email-shawn.guo@freescale.com>
	<19794.17994.381937.158944@ipc1.ka-ro>
Message-ID: <20110211220821.GA9289@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

On Wed, Feb 09, 2011 at 08:46:18AM +0100, Lothar Wa?mann wrote:
> Hi Shawn,
> 
> Shawn Guo writes:
> > This adds the mmc host driver for Freescale MXS-based SoC i.MX23/28.
> > The driver calls into mxs-dma via generic dmaengine api for both pio
> > and data transfer.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > ---
> >  arch/arm/mach-mxs/include/mach/mmc.h |   15 +
> >  drivers/mmc/host/Kconfig             |    9 +
> >  drivers/mmc/host/Makefile            |    1 +
> >  drivers/mmc/host/mxs-mmc.c           |  884 ++++++++++++++++++++++++++++++++++
> >  4 files changed, 909 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-mxs/include/mach/mmc.h
> >  create mode 100644 drivers/mmc/host/mxs-mmc.c
> > 
> I've run the mmc-test kernel module with this driver on our TX28
> module which fails in the following tests:
> |mmc0: Test case 15. Correct xfer_size at write (start failure)...
> |mmc0: Result: ERROR (-110)
> |mmc0: Test case 16. Correct xfer_size at read (start failure)...
> |mmc0: Result: ERROR (-110)
> |mmc0: Test case 17. Correct xfer_size at write (midway failure)...
> |mmc0: Result: ERROR (-110)
> |mmc0: Test case 18. Correct xfer_size at read (midway failure)...
> |mmc0: Result: ERROR (-110)
> 
> Could you try the test on your hardware?
> 
I'm new to this test.  I enabled MMC_TEST but did not see "test"
under /sys for mmc.  Can you please elaborate how to launch this
test?  Thanks.

Regards,
Shawn
