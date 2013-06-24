From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 24 Jun 2013 11:00:46 +0400
Subject: =?UTF-8?B?UmVbMl06IFtQQVRDSCB2MyAxLzVdIGRyaXZlcnM6IGJ1czogaW14LXdlaW06?=
 =?UTF-8?B?IFJlbW92ZSBwcml2YXRlIGRyaXZlciBkYXRh?=
In-Reply-To: <20130623192303.GO32299@pengutronix.de>
References: <1371973698-16150-1-git-send-email-shc_work@mail.ru>
 <20130623192303.GO32299@pengutronix.de>
Message-ID: <1372057246.21852425@f349.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Sun, Jun 23, 2013 at 11:48:14AM +0400, Alexander Shiyan wrote:
> > Driver uses only probe function so no reason to keep variables
> > in private driver data.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  drivers/bus/imx-weim.c | 41 ++++++++++++++---------------------------
> >  1 file changed, 14 insertions(+), 27 deletions(-)
> > 
> > diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
> > index 349f14e..0c0e6fe 100644
> > --- a/drivers/bus/imx-weim.c
> > +++ b/drivers/bus/imx-weim.c
> > @@ -12,11 +12,6 @@
> >  #include <linux/io.h>
> >  #include <linux/of_device.h>
> >  
> > -struct imx_weim {
> > -	void __iomem *base;
> > -	struct clk *clk;
> > -};
> 
> I don't know how others see it, but I would keep the private data now
> that it's there already. We don't know what it's good for in the future
> and it doesn't hurt.
> 
> This is no strong opinion though since it always can be added back when
> it's really needed.

A possible case where private data can be used if we alter this driver to a real bus-driver.
In the current state, the data is not used.
Indeed, the code can be returned later, if it will needed.
Thanks.

---
