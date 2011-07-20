From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 21 Jul 2011 07:13:55 +0800
Subject: [PATCH] arm/mxc: add the missing UART_PADDR for i.mx53
In-Reply-To: <4E2736E0.40105@boundarydevices.com>
References: <1310251913-9877-1-git-send-email-troy.kisky@boundarydevices.com>
	<1311167599-21790-1-git-send-email-shawn.guo@linaro.org>
	<20110720130830.GD2377@pengutronix.de>
	<20110720132418.GB6999@S2100-06.ap.freescale.net>
	<20110720132720.GE2377@pengutronix.de>
	<20110720134426.GD6999@S2100-06.ap.freescale.net>
	<20110720134530.GA15471@pengutronix.de>
	<4E2736E0.40105@boundarydevices.com>
Message-ID: <20110720231354.GJ6999@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2011 at 01:13:20PM -0700, Troy Kisky wrote:
> On 7/20/2011 6:45 AM, Wolfram Sang wrote:
> > On Wed, Jul 20, 2011 at 09:44:27PM +0800, Shawn Guo wrote:
> >> On Wed, Jul 20, 2011 at 03:27:20PM +0200, Wolfram Sang wrote:
> >>>>> Then you should at least add his Signed-off. And maybe also mark him as
> >>>>> the author of the patch?
> >>>>>
> >>>> I did exactly what you suggested here on a mx53 fec patch, but I was
> >>>> told by Troy to change his s-o-b to reported-by.  So let's see what
> >>>> he would say about this one.
> >>>
> >>> Okay, not much of a deal for such a patch. Though, I have doubts if one
> >>> can request removing the SoB for a patch other people put work on top
> >>> of.
> >>>
> >> So you are telling you are not following the list closely?
> > 
> > If "following closely" == "reading every single mail", then surely not.
> > Why?
> > 
> Shawn,
> 
> The reason I requested to change to reported-by on the FEC patch was
> because your patch was extremely different from mine and you deserved to
> be listed as the author, not me.
> 
> 
> For this, both patches are tiny. And since I still think that
> CONFIG_ARCH_MX53 is more appropriate than CONFIG_SOC_IMX53,
> I am also fine with a reported-by. Though your commit message
> could be better. It is a run time problem, not compile-time.
> 
No.  It is a compile-time problem.  The reason we see difference there
is because I based off linux-next (essentially linux-arm-soc/next <-
Sascha's 'devel' branch), while you probably based off Sascha's
for-next branch.

Sascha,

You forgot to apply the following patch on your for-next branch?

commit fad107086d5a869c1c07e5bb35b7b57a10ecf578
Author: Sascha Hauer <s.hauer@pengutronix.de>
Date:   Thu May 19 17:25:05 2011 +0200

    ARM i.MX debug macro: use CONFIG_SOC_* instead of CONFIG_ARCH_*

    CONFIG_ARCH_* are deprecated, so remove one user.

    Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

I think you still need to keep your for-next branch as a bleeding-edge
for i.mx since people base their i.mx works off there.

-- 
Regards,
Shawn
