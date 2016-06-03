From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 3 Jun 2016 22:01:07 +0800
Subject: [PATCH] ARM: imx25-pinfunc: remove SION from all modes
In-Reply-To: <20160603133247.GV26768@pengutronix.de>
References: <1461095114-11745-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20160419211958.GD19428@n2100.arm.linux.org.uk>
 <20160420104617.15cf8461@ipc1.ka-ro>
 <20160420085839.GI29108@pengutronix.de>
 <20160603133247.GV26768@pengutronix.de>
Message-ID: <20160603140107.GA8659@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2016 at 03:32:47PM +0200, Uwe Kleine-K?nig wrote:
> I found a regression of the patch under discussion (which was not
> applied, so no big problem). On the custom mx25 based hardware an
> SD-card isn't detected any more after removing SION from
> MX25_PAD_SD1_CMD__SD1_CMD. I verified the same happens on a tx25.
> 
> Is this expected? IMHO it's unfortunate (if not a silicon bug) that you
> need the SION bit here as the SION bit has some more side effects.  If
> you ask me, muxing a certain function for a pin should enable the input
> path to the respective module if the pin is bidirectional.
> 
> Is there a list of pin/function pairs that need the SION bit set? Shawn,
> would you agree to accept this patch with the high risk that it
> introduces regressions? Or maybe we should make the SION bit more easily
> overridable for board dts files (and default to off unless known it's
> needed)?

I would be conservative on this.  Can we just fix the SION bits that are
known doing harm?

Shawn
