From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 10 Nov 2011 09:47:06 +0100
Subject: [PATCH] ARM: mx28evk: Simplify GPIO requests for mx28evk_fec_reset
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F7722CB848@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1320865742-16768-1-git-send-email-fabio.estevam@freescale.com>
 <20111110075324.GQ16886@pengutronix.de>
 <65EE16ACC360FA4D99C96DC085B3F7722CB848@039-SN1MPN1-002.039d.mgd.msft.net>
Message-ID: <20111110084706.GV16886@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2011 at 08:11:10AM +0000, Dong Aisheng-B29396 wrote:
> > 
> > I think it makes more sense to create an array per board and not per
> > board function. In the mx28evk file we use gpios for the fec, we have a
> > gpio_request_one for the flexcan switch and a gpio_request_array for the
> > lcd pins. All these could be added to a single mx28evk_gpios array.
> > Then it would be easy to see which gpios a board uses and it would be
> > trivial to add additional gpios. The same applies for other boards aswell
> > of course.
> > 
> One question is that if one gpio, assume in one function like fec, request fail
> will cause the whole gpio array request fail.

They don't fail. If they do it means we have a duplicate entry in the
table or otherwise screwed up the kernel. I think a single pr_err("bad
things may happen, continue and hope for the best") is enough here.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
