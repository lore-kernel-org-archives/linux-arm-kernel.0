From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 12 May 2012 13:36:30 +0200
Subject: [PATCH 0/4] MXS: I2C improvements
In-Reply-To: <201205092033.46812.marex@denx.de>
References: <1335837621-14816-1-git-send-email-marex@denx.de>
 <201205092033.46812.marex@denx.de>
Message-ID: <20120512113630.GE20673@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 08:33:46PM +0200, Marek Vasut wrote:
> > This patchset implements support for adjustment of I2C bus speed via
> > platform data. Further, it implements support for DMA transfers into the
> > mxs-i2c driver. Lastly, there is a fix for GCC4.7 warning included.
> > 
> > Marek Vasut (4):
> >   MXS: Allow passing i2c bus speed via platform data
> >   MXS: Set I2C timing registers for mxs-i2c
> >   MXS: Implement DMA support into mxs-i2c
> >   MXS: Fix GCC4.7 complaint in mxs-i2c
> 
> Bump?

Regarding I2C, I think we will have DT support for it already in 3.5.
So, I am with Shawn here to not introduce new features with new
platform_data when there is a more recent alternative. So, drop 1/4 and
refactor 2/4 according to DT (you only need to get and parse the
"clock-frequency" property).

3/4 is the most interesting patch of this series, since it is a major
bugfix. Due to holidays, I won't be able to test it in the next 10 days,
but I am very eager to get it into 3.5. Since it is a bugfix, we could
probably get it in after the merge window, but I'll try to make the
merge window nontheless. If somebody donates Tested or Acked or Reviewed
tags, that would also help.

I already NACKed 4/4, so I wonder why you resent it.

Thanks,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120512/dce3f5fa/attachment.sig>
