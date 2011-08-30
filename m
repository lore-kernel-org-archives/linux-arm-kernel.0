From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 30 Aug 2011 17:55:06 +0200
Subject: [PATCH] arm: mach-imx: enable all uart clocks for DEBUG_LL
In-Reply-To: <20110830152725.GC19359@S2100-06.ap.freescale.net>
References: <1314269856-20000-1-git-send-email-w.sang@pengutronix.de>
	<20110830145606.GB19359@S2100-06.ap.freescale.net>
	<20110830152725.GC19359@S2100-06.ap.freescale.net>
Message-ID: <20110830155506.GD2053@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2011 at 11:27:26PM +0800, Shawn Guo wrote:
> On Tue, Aug 30, 2011 at 10:56:07PM +0800, Shawn Guo wrote:
> > On Thu, Aug 25, 2011 at 12:57:36PM +0200, Wolfram Sang wrote:
> > > If you want to move the DEBUG_LL uart, simply changing the base address
> > > in debug-macro.S will not be enough. One needs to enable the correct
> > > clock during clock init, too, otherwise the kernel remains silent. This
> > > is too easy to forget, so enable all uart clocks for DEBUG_LL to save
> > > precious developer time.
> > > 
> > I guess the patch is not welcomed from the power management POV.

Anything prefixed with DEBUG_* should be kinda safe from that POV :)

> > Shouldn't bootloader have enabled the clock for debug uart anyway?
> > 
> Hmm, bootloader should be the only one who can enable the clock for
> DEBUG_LL uart, as DEBUG_LL could be used at the very early point of
> kernel booting.

That would mean: remove all #ifdef CONFIG_DEBUG_LL and make sure the
clock won't get turned off during init. Sounds better to me, yet have to
have another look...

Thanks!

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110830/c8df64e6/attachment.sig>
