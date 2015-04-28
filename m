From: eddie.huang@mediatek.com (Eddie Huang)
Date: Tue, 28 Apr 2015 16:44:48 +0800
Subject: [PATCH v6 3/3] I2C: mediatek: Add driver for MediaTek MT8173
 I2C controller
In-Reply-To: <553F4681.7040404@pengutronix.de>
References: <1430209869-6631-1-git-send-email-eddie.huang@mediatek.com>
 <1430209869-6631-4-git-send-email-eddie.huang@mediatek.com>
 <553F4681.7040404@pengutronix.de>
Message-ID: <1430210688.26793.1.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Tue, 2015-04-28 at 10:36 +0200, Marc Kleine-Budde wrote:
> On 04/28/2015 10:31 AM, Eddie Huang wrote:
> > Add mediatek MT8173 I2C controller driver. Compare to I2C controller
> > of earlier mediatek SoC, MT8173 fix write-then-read limitation, and
> > also increase message size to 64kb.
> > 
> > Signed-off-by: Xudong Chen <xudong.chen@mediatek.com>
> > Signed-off-by: Liguo Zhang <liguo.zhang@mediatek.com>
> > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > ---
> >  drivers/i2c/busses/i2c-mt65xx.c | 106 +++++++++++++++++++++++++++++-----------
> >  1 file changed, 77 insertions(+), 29 deletions(-)
> > 
> > diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> > index 2ecf0d1..c501421 100644
> > --- a/drivers/i2c/busses/i2c-mt65xx.c
> > +++ b/drivers/i2c/busses/i2c-mt65xx.c
> [...]
> 
> >  static const struct of_device_id mtk_i2c_of_match[] = {
> >  	{ .compatible = "mediatek,mt6577-i2c", .data = (void *)&mt6577_compat },
> >  	{ .compatible = "mediatek,mt6589-i2c", .data = (void *)&mt6589_compat },
> > +	{ .compatible = "mediatek,mt8173-i2c", .data = (void *)&mt8173_compat },
> >  	{}
> >  };
> > -MODULE_DEVICE_TABLE(of, mtk_i2c_match);
> > +MODULE_DEVICE_TABLE(of, mtk_i2c_of_match);
> 
> This should go into the previous patch, as 2/3 will probably not compile
> without this change.
> 
That's right, my mistake, should be in 2/3. 

Eddie
