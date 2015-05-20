From: eddie.huang@mediatek.com (Eddie Huang)
Date: Wed, 20 May 2015 10:53:22 +0800
Subject: [PATCH v8 3/3] I2C: mediatek: Add driver for MediaTek MT8173
 I2C controller
In-Reply-To: <CABuKBeKJ=V6bP9iU9xDN0JecTTFoLDUfsX_QP5rpPj1bn167Vg@mail.gmail.com>
References: <1431967209-5261-1-git-send-email-eddie.huang@mediatek.com>
 <1431967209-5261-4-git-send-email-eddie.huang@mediatek.com>
 <CABuKBeKJ=V6bP9iU9xDN0JecTTFoLDUfsX_QP5rpPj1bn167Vg@mail.gmail.com>
Message-ID: <1432090402.13819.14.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On Tue, 2015-05-19 at 16:45 +0200, Matthias Brugger wrote:
> 2015-05-18 18:40 GMT+02:00 Eddie Huang <eddie.huang@mediatek.com>:
> > Add mediatek MT8173 I2C controller driver. Compare to I2C controller
> > of earlier mediatek SoC, MT8173 fix write-then-read limitation, and
> > also increase message size to 64kb.
> >
> > Signed-off-by: Xudong Chen <xudong.chen@mediatek.com>
> > Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
> > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/i2c/busses/i2c-mt65xx.c | 94 +++++++++++++++++++++++++++++------------
> >  1 file changed, 67 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> > index 7462f05..1ebbf1a 100644
> > --- a/drivers/i2c/busses/i2c-mt65xx.c
> > +++ b/drivers/i2c/busses/i2c-mt65xx.c
> > @@ -33,10 +33,13 @@
> >  #include <linux/sched.h>
> >  #include <linux/slab.h>
> >
> > +#define I2C_RS_TRANSFER                        (1 << 4)
> 
> As far as I can see, mt6589 and mt8127 don't have this bit defined in
> their datasheets (and most probably others neither).
> Is it save to write this bit, although it is not implemented?

I think it is safe to write this bit. Since other guys may have the same
question, I will modify to write I2C_RS_TRANSFER only when this bit
exist.

Eddie
