From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 18 Apr 2011 09:42:02 +0200
Subject: [RFC] sanitizing crazy clock data files
In-Reply-To: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110418074202.GA15233@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 09:08:05PM +0200, Sascha Hauer wrote:
> The following tries to solve the chicken-egg problem we have with the
> common struct clk support and its users. It switches i.MX51 clock support
> to the new API. Included are some generic clock helpers for dividers and
> multiplexer. I first made them i.MX specific but after looking round in
> the other architectures I found them useful enough for other architectures
> aswell. If you could use the helpers but missing some bits please speak up.

Note that this series also changes the way clocks are organized. We have
many clocks on i.MX which implemenent set_parent and set_rate at
once. Now with the split into building blocks only the multiplexers
implement set_parent. It's no longer possible in general to call
set_parent on clocks given to drivers as these are mostly dividers and
gates which do not allow to change its parent.

The upside of this change is that it's really simple and straight
forward to implement a clock tree which can be easily reviewed with
the datasheet.

There will be updates to this series as I found some leftovers from
earlier versions of this series.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
