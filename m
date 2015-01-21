From: eddie.huang@mediatek.com (Eddie Huang)
Date: Wed, 21 Jan 2015 16:34:35 +0800
Subject: [PATCH v4 2/2] I2C: mediatek: Add driver for MediaTek I2C
 controller
In-Reply-To: <20150121082022.GT22880@pengutronix.de>
References: <1421404418-50718-1-git-send-email-eddie.huang@mediatek.com>
 <1421404418-50718-3-git-send-email-eddie.huang@mediatek.com>
 <20150118101816.GF22880@pengutronix.de>
 <1421810004.15468.825.camel@mtksdaap41>
 <20150121082022.GT22880@pengutronix.de>
Message-ID: <1421829275.6546.6.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Wed, 2015-01-21 at 09:20 +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Wed, Jan 21, 2015 at 11:13:24AM +0800, Eddie Huang wrote:
> > > > +	/* set when doing the transfer */
> > > > +	u16 irq_stat;			/* interrupt status */
> > > > +	unsigned int speed_hz;		/* The speed in transfer */
> > > > +	bool trans_stop;		/* i2c transfer stop */
> > > > +	enum mtk_trans_op op;
> > > > +	u16 msg_len;
> > > > +	u8 *msg_buf;			/* pointer to msg data */
> > > > +	u16 msg_aux_len;		/* WRRD mode to set AUX_LEN register*/
> > > > +	u16 addr;	/* 7bit slave address, without read/write bit */
> > > Wouldn't it be easier to maintain a pointer to the message to be
> > > transferred?
> > I think use mtk_i2c pointer is more flexible than maintain a pointer to
> > message.
> Not sure you understood what I intended to suggest. My idea was to drop
> 
> 	u16 msg_len;
> 	u8 *msg_buf;
> 	u16 msg_aux_len; // maybe
> 	u16 addr;
> 
> from struct mtk_i2c and add a struct i2c_msg *msg instead. Up to you to
> decide.
> 
Because this driver pass mtk_i2c pointer between functions, it's
flexible to use any member of struct mtk_i2c. The good thing is avoid
passing one more struct i2c_msg parameter between functions, or another
struct copy. The bad thing is make struct mtk_i2c larger. I prefer to
keep as it is now.

Best Regards
Eddie
