From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 24 Nov 2015 12:19:21 +0100
Subject: [PATCH v2] clk: imx25: Remove osc clock from driver
In-Reply-To: <20151124035349.GE11999@tiger>
References: <1445839848-28323-1-git-send-email-mpa@pengutronix.de>
 <20151124035349.GE11999@tiger>
Message-ID: <2985109.TyRxRSpDc1@adelgunde>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Tuesday 24 November 2015 11:53:49 Shawn Guo wrote:
> On Mon, Oct 26, 2015 at 07:10:48AM +0100, Markus Pargmann wrote:
> > The 'osc' clock is already initialized by the fixed clock defined in
> > imx25.dtsi. The imx25 clock driver tries to add this clock for a second
> > time and fails with -EEXIST:
> > 	i.MX clk 1: register failed with -17
> > 
> > As the clock is already properly setup in DT with a different driver, we
> > can completely remove the handling in the imx25 clock driver.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> 
> Markus,
> 
> Please resend the patch with clock maintainers and list on copy.  If you
> think it's a non-critical fix, I will queue it for v4.5-rc1.  Otherwise,
> you ask clock maintainers to send it for v4.4-rc inclusion.

I just resent this patch (and rebased it). This is a non-critical fix and
4.5-rc1 is fine.

Best Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151124/7043dca7/attachment.sig>
