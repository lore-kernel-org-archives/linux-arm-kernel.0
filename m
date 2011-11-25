From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 25 Nov 2011 09:15:20 +0800
Subject: [PATCH] i2c-mxs: fix compile warning in mxs_i2c_xfer()
In-Reply-To: <20111124083747.GE8439@pengutronix.de>
References: <1322121140-5216-1-git-send-email-shawn.guo@linaro.org>
 <20111124082903.GV19986@pengutronix.de>
 <20111124083747.GE8439@pengutronix.de>
Message-ID: <20111125011519.GA18403@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 09:37:47AM +0100, Wolfram Sang wrote:
> On Thu, Nov 24, 2011 at 09:29:03AM +0100, Uwe Kleine-K?nig wrote:
> > Hello Shawn,
> > 
> > On Thu, Nov 24, 2011 at 03:52:20PM +0800, Shawn Guo wrote:
> > >   CC      drivers/i2c/busses/i2c-mxs.o
> > > drivers/i2c/busses/i2c-mxs.c: In function ?mxs_i2c_xfer?:
> > > drivers/i2c/busses/i2c-mxs.c:196:6: warning: ?data? may be used uninitialized in this function
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > ---
> > >  drivers/i2c/busses/i2c-mxs.c |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > 
> > > diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> > > index 7e78f7c..00f098f 100644
> > > --- a/drivers/i2c/busses/i2c-mxs.c
> > > +++ b/drivers/i2c/busses/i2c-mxs.c
> > > @@ -193,7 +193,7 @@ static int mxs_i2c_wait_for_data(struct mxs_i2c_dev *i2c)
> > >  
> > >  static int mxs_i2c_finish_read(struct mxs_i2c_dev *i2c, u8 *buf, int len)
> > >  {
> > > -	u32 data;
> > > +	u32 data = 0;
> > >  	int i;
> > >  
> > >  	for (i = 0; i < len; i++) {
> > Looks like a stupid compiler. Then better use 
> > 
> > 	u32 uninitialized_var(data);
> 
> Leave it as it is and fix the compiler? Will do another test later to make
> sure.
> 
Ben, do you have an opinion on this, leave it there or fix it?

-- 
Regards,
Shawn
