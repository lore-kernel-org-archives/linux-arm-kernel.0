From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 15 Jun 2011 12:29:49 +0800
Subject: [PATCH v2 5/6] ARM: mxc: all three imx51 TOs use TO1 version of
	sdma script
In-Reply-To: <20110614203809.GA23771@pengutronix.de>
References: <1307950645-26529-6-git-send-email-shawn.guo@linaro.org>
	<1308032407-3860-1-git-send-email-shawn.guo@linaro.org>
	<20110614203809.GA23771@pengutronix.de>
Message-ID: <20110615042948.GB31712@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2011 at 10:38:09PM +0200, Sascha Hauer wrote:
> On Tue, Jun 14, 2011 at 02:20:07PM +0800, Shawn Guo wrote:
> > Though there are three TOs of imx51 soc, the sdma script never
> > changes since TO1, which means all three TOs of imx51 uses TO1
> > version of sdma script.
> > 
> > The current code passes TO number to imx-sdma driver to load
> > different firmware for different TO.  That means we have to prepare
> > 3 identical firmwares, sdma-imx51-to1.bin sdma-imx51-to2.bin and
> > sdma-imx51-to3.bin, to have the kernel capable of running on all
> > three TOs.  This just makes no sense.
> > 
> > The patch removes the TO number passing and get the default TO1
> > version of sdma firmware work for all TOs.
> 
> I don't agree to this approach. The SDMA firmware has been different on
> all TO versions of earlier i.MXs. For the linearity of the universe we
> should keep this. What about providing a link in userspace?
> 
The fact is that mx31 and mx35 are the only two SoCs (relatively old
ones) that have different SDMA firmwares on different TOs.  The
relatively new ones, mx25 (TO1, TO1.1), mx50 (TO1, TO1.1), mx51
(TO1, TO2, TO3) and mx53 (TO1, TO2) all have one version SDMA
firmware for different TOs.  I do not see the mx31/35 case is a
linearity of the universe.  Do we really want to bother ourselves
with userspace link on so many latest SoCs?

-- 
Regards,
Shawn
