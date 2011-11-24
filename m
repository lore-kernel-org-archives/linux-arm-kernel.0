From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 24 Nov 2011 10:11:47 +0100
Subject: [PATCH] i2c-mxs: fix compile warning in mxs_i2c_xfer()
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F77233A4E4@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1322121140-5216-1-git-send-email-shawn.guo@linaro.org>
 <20111124082903.GV19986@pengutronix.de>
 <20111124083747.GE8439@pengutronix.de>
 <65EE16ACC360FA4D99C96DC085B3F77233A4E4@039-SN1MPN1-002.039d.mgd.msft.net>
Message-ID: <20174.2643.823394.322927@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dong Aisheng-B29396 writes:
> > -----Original Message-----
> > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> > kernel-bounces at lists.infradead.org] On Behalf Of Wolfram Sang
> > Sent: Thursday, November 24, 2011 4:38 PM
> > To: Uwe Kleine-K?nig
> > Cc: Shawn Guo; linux-arm-kernel at lists.infradead.org; Ben Dooks; linux-
> > i2c at vger.kernel.org
> > Subject: Re: [PATCH] i2c-mxs: fix compile warning in mxs_i2c_xfer()
> > 
> > On Thu, Nov 24, 2011 at 09:29:03AM +0100, Uwe Kleine-K?nig wrote:
> > > Hello Shawn,
> > >
> > > On Thu, Nov 24, 2011 at 03:52:20PM +0800, Shawn Guo wrote:
> > > >   CC      drivers/i2c/busses/i2c-mxs.o
> > > > drivers/i2c/busses/i2c-mxs.c: In function ?mxs_i2c_xfer?:
> > > > drivers/i2c/busses/i2c-mxs.c:196:6: warning: ?data? may be used
> > > > uninitialized in this function
> > > >
> > > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > > ---
> > > >  drivers/i2c/busses/i2c-mxs.c |    2 +-
> > > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > >
> > > > diff --git a/drivers/i2c/busses/i2c-mxs.c
> > > > b/drivers/i2c/busses/i2c-mxs.c index 7e78f7c..00f098f 100644
> > > > --- a/drivers/i2c/busses/i2c-mxs.c
> > > > +++ b/drivers/i2c/busses/i2c-mxs.c
> > > > @@ -193,7 +193,7 @@ static int mxs_i2c_wait_for_data(struct
> > > > mxs_i2c_dev *i2c)
> > > >
> > > >  static int mxs_i2c_finish_read(struct mxs_i2c_dev *i2c, u8 *buf,
> > > > int len)  {
> > > > -	u32 data;
> > > > +	u32 data = 0;
> > > >  	int i;
> > > >
> > > >  	for (i = 0; i < len; i++) {
> > > Looks like a stupid compiler. Then better use
> > >
> > > 	u32 uninitialized_var(data);
> > 
> > Leave it as it is and fix the compiler? Will do another test later to
> > make sure.
> > 
> 
> Compiler is wrong?
> Just from the code that it seems to be right the 'data' might be used
> uninitialized.
> 
Only iff you assume that (0 & 3) could be != 0...


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
