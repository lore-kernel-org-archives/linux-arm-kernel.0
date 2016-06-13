From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 13 Jun 2016 12:16:16 +0200
Subject: [PATCH] ARM: imx25-pinfunc: remove SION from all modes
In-Reply-To: <20160603193148.GW26768@pengutronix.de>
References: <1461095114-11745-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20160419211958.GD19428@n2100.arm.linux.org.uk>
 <20160420104617.15cf8461@ipc1.ka-ro>
 <20160420085839.GI29108@pengutronix.de>
 <20160603133247.GV26768@pengutronix.de>
 <20160603140107.GA8659@tiger>
 <20160603193148.GW26768@pengutronix.de>
Message-ID: <20160613101616.GK26768@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Fri, Jun 03, 2016 at 09:31:48PM +0200, Uwe Kleine-K?nig wrote:
> On Fri, Jun 03, 2016 at 10:01:07PM +0800, Shawn Guo wrote:
> > On Fri, Jun 03, 2016 at 03:32:47PM +0200, Uwe Kleine-K?nig wrote:
> > > I found a regression of the patch under discussion (which was not
> > > applied, so no big problem). On the custom mx25 based hardware an
> > > SD-card isn't detected any more after removing SION from
> > > MX25_PAD_SD1_CMD__SD1_CMD. I verified the same happens on a tx25.
> > > 
> > > Is this expected? IMHO it's unfortunate (if not a silicon bug) that you
> > > need the SION bit here as the SION bit has some more side effects.  If
> > > you ask me, muxing a certain function for a pin should enable the input
> > > path to the respective module if the pin is bidirectional.
> > > 
> > > Is there a list of pin/function pairs that need the SION bit set? Shawn,
> > > would you agree to accept this patch with the high risk that it
> > > introduces regressions? Or maybe we should make the SION bit more easily
> > > overridable for board dts files (and default to off unless known it's
> > > needed)?
> > 
> > I would be conservative on this.  Can we just fix the SION bits that are
> > known doing harm?
> 
> I didn't do any measurements, but I'd expect that every SION bit that is
> set without good reason increases current consumption. So each SION bit
> does some harm. Plus debugging a missing SION bit is much easier than a
> SION bit that is set without need.
> 
> The first problem I debugged was an UART problem and the SION bit had to
> be removed from MX25_PAD_KPP_ROW3__GPIO_3_0 (plus back then
> MX25_PAD_KPP_ROW3__UART1_RI wasn't defined). The problem I had now was a
> broken SD card and I had to add SION to MX25_PAD_SD1_CMD__SD1_CMD.
> 
> So I expect my commit to (maybe) introduce some obvious and easy to
> debug regressions and to (probably) fix some harder to debug and not so
> obvious problems. I'd say it's a net win.

I didn't hear anything back from you on this topic. So I created a patch
that documents that SION is needed for MX25_PAD_SD1_CMD__SD1_CMD and
then rebased the patch under discussion on top of that. I will send the
resulting patches as reply to this mail. IMHO the first patch should not
be controversal.

I still think that the second patch is a good one, did your view change?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
