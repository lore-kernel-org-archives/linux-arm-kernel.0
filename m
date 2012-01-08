From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sun, 8 Jan 2012 15:45:58 +0100
Subject: mxs: enable phy-clock in the driver?
Message-ID: <20120108144558.GB2544@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

I recently noticed that my tx28 board did not have net when booting from NAND
(before that, barebox was setting up the network). Adding lines like these from
mx28evk helped:

228         /* Enable fec phy clock */
229         clk = clk_get_sys("pll2", NULL);
230         if (!IS_ERR(clk))
231                 clk_enable(clk);

So, if every board seems to need this, I'd think this should rather be in the
driver? Am I correct or is there something I have overlooked?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120108/33bc4499/attachment.sig>
