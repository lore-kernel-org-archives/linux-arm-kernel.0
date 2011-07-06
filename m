From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 6 Jul 2011 18:29:35 +0200
Subject: [PATCH] Add 'config IMX_NFC_V1_BISWAP' to swap the Bad block
	Indicator, and use for imx27pdk nand support.
In-Reply-To: <19988.26817.208939.223896@ipc1.ka-ro>
References: <1309872828-13942-1-git-send-email-J.Lambrecht@televic.com>
	<20110706080942.GC26347@pengutronix.de>
	<4E142B18.60407@televic.com> <19988.19315.787284.113228@ipc1.ka-ro>
	<4E145789.8040801@televic.com>
	<19988.26817.208939.223896@ipc1.ka-ro>
Message-ID: <20110706162935.GV6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 03:53:05PM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> Lambrecht J?rgen writes:
> > On 07/06/2011 01:48 PM, Lothar Wa?mann wrote:
> > > > Am I correct that all nfc-v1's have that bug, so only imx27 and imx51?
> > > > The application note we finally got from freescale only mentions "FSL
> > > > IMX NFC".
> > > >
> > > It's not exactly a bug (which would be possible to get fixed), but an
> > > inherent feature of the controller which handles NAND flash with a
> > > page size larger than 512 byte like it has n pages of 512 byte.
> > >
> > OK, a "hardware bug" then (can be fixed with a re-write of the 
> > VHDL/Verilog code of the NFC, giving v2). It seems to me Freescale tried 
> > to enhance their 512B-page controller with to possibility to also handle 
> > 2kB pages, but they forgot about the Factory Bad Block byte (n=4 only).
> > So to reply to your next mail: only the imx27 and imx31 (thanks sascha, 
> > it was a typo to mention 51) have the NFC v1, I believe all the others 
> > have NFC v2, which are fixed.
> > 
> How do you come to that conclusion?

I remember fsl code which does this only for the v1 controller, but I
can't find this anymore, so maybe my mind fooled me.
Have you checked this somehow that it is indeed swapped for all
controllers or do you believe the fsl code?

> All the controllers share the same
> flash buffer layout and map it to the actual flash data in the same
> way. Thus the problem exists for all of them.
> And the original Freescale code for i.MX5 et al. handles the bad block
> markers in the same way as for i.MX2 or i.MX3.

Indeed :(
