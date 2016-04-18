From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 18 Apr 2016 12:07:27 +0200
Subject: [PATCH RESEND] gpmi-nand: Handle ECC Errors in erased pages
In-Reply-To: <20160415174031.3c088df5@bbrezillon>
References: <1456059126-25469-1-git-send-email-mpa@pengutronix.de>
 <AM4PR0401MB1841C82A9BCBFF2C55AA4DC397680@AM4PR0401MB1841.eurprd04.prod.outlook.com>
 <20160415174031.3c088df5@bbrezillon>
Message-ID: <12179071.kte6qB1Shv@adelgunde>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 April 2016 17:40:31 Boris Brezillon wrote:
> On Fri, 15 Apr 2016 15:33:07 +0000
> Han Xu <han.xu@nxp.com> wrote:
> 
> > >
> > > I just did [1] (it applies on top of your patch), but maybe you
> > > can test it (I don't have any imx platforms right now) ;).
> > 
> > Great, thank you :). I just tested the patch and it works for me. The
> > erased page bitflips are still detected and fixed. I will send a new
> > version then.
> > 
> > Hi Markus,
> > 
> > Could you please share how to verify the patch, in other words, how to reproduce the
> > UBIFS corruption issue consistently. Thanks.

I used a simple bashscript with 'nandwrite --noecc' that writes a number
of zeroes in every sub-page. For written pages the ECC will handle the
flips. For erased pages we can test the algorithm that handles the
erased page bitflips.

> 
> I should really post a new version of the nandflipbits tool [1].
> That's clearly the easiest solution to verify that your bitflip
> correction is reliable.

Seems really useful.

Best Regards,

Markus

> 
> 
> [1]http://lists.infradead.org/pipermail/linux-mtd/2014-November/056634.html
> 
> 

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160418/b0f1222c/attachment-0001.sig>
