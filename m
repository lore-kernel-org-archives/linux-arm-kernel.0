From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 10 May 2016 11:47:38 +0300
Subject: [PATCH v2 0/3] video: fbdev: imxfb: make it work again
In-Reply-To: <1462354998-5792-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1462354998-5792-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <5731A02A.2070309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/05/16 12:43, Uwe Kleine-K?nig wrote:
> Hello,
> 
> this is v2 of the series which addresses the review comments I got vor
> (implicit) v1.
> 
> For patch 2 the question is still open if this is the right fix, but
> without this the display doesn't stay on. Patches 1 and 3 should be
> applicable independant of patch 2.

I picked patches 1 and 3, they look fine.

I still think patch 2 is just broken, it doesn't make sense to me.

If the regulator is enabled in probe, then it's always on, and
imxfb_lcd_set_power() should be removed as it never has any effect. But
that doesn't sound correct, as presumably the imxfb_lcd_set_power() has
worked at some point.

And shouldn't the regulator be disabled at least when suspending?

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160510/10c1277f/attachment.sig>
