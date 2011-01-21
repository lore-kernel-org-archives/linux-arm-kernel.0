From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 21 Jan 2011 22:45:30 +0800
Subject: [PATCH 5/6] dmaengine: imx-sdma: fix up param for the last BD
	in sdma_prep_slave_sg()
In-Reply-To: <20110121102424.GB9041@pengutronix.de>
References: <1295473840-17295-1-git-send-email-shawn.guo@freescale.com>
	<1295473840-17295-6-git-send-email-shawn.guo@freescale.com>
	<20110120102808.GX9041@pengutronix.de>
	<20110121151537.GA1897@S2101-09.ap.freescale.net>
	<20110121102424.GB9041@pengutronix.de>
Message-ID: <20110121144528.GA13825@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Fri, Jan 21, 2011 at 11:24:24AM +0100, Sascha Hauer wrote:
> On Fri, Jan 21, 2011 at 11:15:39PM +0800, Shawn Guo wrote:
> > Hi Sascha,
> > 
> > On Thu, Jan 20, 2011 at 11:28:08AM +0100, Sascha Hauer wrote:
> > > On Thu, Jan 20, 2011 at 05:50:39AM +0800, Shawn Guo wrote:
> > > > As per the reference manual, bit "L" should be set while bit "C"
> > > > should be cleared for the last buffer descriptor in the non-cyclic
> > > > chain, so that sdma can stop trying to find the next BD and end
> > > > the transfer.
> > > > 
> > > > In case of sdma_prep_slave_sg(), BD_LAST needs to be set and BD_CONT
> > > > be cleared for the last BD.
> > > 
> > > Did you test this patch?
> > > 
> > Would you suggest any driver on mx51 using this api?  So that I can
> > test it on my babbage board.  Or you can help test it with mx27/31
> > mmc driver?  I do not have them on my end.  Thanks.
> 
> I can only suggest the imx/imx-sdma-sound-mx353ds-mx51_babbage
> branch, but this only uses cyclic transfers so you can't use it
> to test this patch.
Yes, I tested the patch set against imx/imx-sdma-sound-mx353ds-mx51_babbage.
But the only use of sdma_prep_slave_sg I know is mxcmmc.c that you
patched recently.  And this driver is for mx27/31 which I do not have
the setup.

> I asked because I could add an ack to this patch if it has been
> tested. Without testing I'd like delaying it until I found some
> time testing it.
Reasonable.  Thanks.

-- 
Regards,
Shawn
