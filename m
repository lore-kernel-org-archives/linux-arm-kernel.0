From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 21 Jan 2015 09:20:22 +0100
Subject: [PATCH v4 2/2] I2C: mediatek: Add driver for MediaTek I2C
 controller
In-Reply-To: <1421810004.15468.825.camel@mtksdaap41>
References: <1421404418-50718-1-git-send-email-eddie.huang@mediatek.com>
 <1421404418-50718-3-git-send-email-eddie.huang@mediatek.com>
 <20150118101816.GF22880@pengutronix.de>
 <1421810004.15468.825.camel@mtksdaap41>
Message-ID: <20150121082022.GT22880@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Jan 21, 2015 at 11:13:24AM +0800, Eddie Huang wrote:
> > > +	/* set when doing the transfer */
> > > +	u16 irq_stat;			/* interrupt status */
> > > +	unsigned int speed_hz;		/* The speed in transfer */
> > > +	bool trans_stop;		/* i2c transfer stop */
> > > +	enum mtk_trans_op op;
> > > +	u16 msg_len;
> > > +	u8 *msg_buf;			/* pointer to msg data */
> > > +	u16 msg_aux_len;		/* WRRD mode to set AUX_LEN register*/
> > > +	u16 addr;	/* 7bit slave address, without read/write bit */
> > Wouldn't it be easier to maintain a pointer to the message to be
> > transferred?
> I think use mtk_i2c pointer is more flexible than maintain a pointer to
> message.
Not sure you understood what I intended to suggest. My idea was to drop

	u16 msg_len;
	u8 *msg_buf;
	u16 msg_aux_len; // maybe
	u16 addr;

from struct mtk_i2c and add a struct i2c_msg *msg instead. Up to you to
decide.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
