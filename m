From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 15 Aug 2013 07:08:42 +0200
Subject: [PATCH 5/5] pinctrl: imx: Use struct type for pins
In-Reply-To: <CACRpkdZk4jz3dg6aoZqsMT5VXJUQxwrZOyAVLCU3UsExAXChAA@mail.gmail.com>
References: <1376050854-3303-1-git-send-email-s.hauer@pengutronix.de>
 <1376050854-3303-6-git-send-email-s.hauer@pengutronix.de>
 <CACRpkdZk4jz3dg6aoZqsMT5VXJUQxwrZOyAVLCU3UsExAXChAA@mail.gmail.com>
Message-ID: <20130815050842.GF26614@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 10:41:20PM +0200, Linus Walleij wrote:
> On Fri, Aug 9, 2013 at 2:20 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> 
> > The i.MX pinctrl driver uses 5 different arrays for storing the
> > informations for pins. This requires five allocations. Instead,
> > use a struct type which is more cache friendly, readable and
> > requires less allocations. One array of integers is still needed
> > since the pinctrl framework forces us to maintain it.
> > This also adds checks whether the allocations are succesful which
> > were missing.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Hm appears to be dependent on 4/5 so can't apply this one
> in isolation ... but it looks good.
> 
> Would be nice to have a handshake from Shawn and/or Dong
> on these patches BTW.

What do you mean with handshake? Shawn acked the series.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
