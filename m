From: l.fu@pengutronix.de (Luotao Fu)
Date: Thu, 1 Jul 2010 12:50:43 +0200
Subject: [PATCH] imxfb: add flag to avoid disabling clk multiple times
In-Reply-To: <4C1CE6B8.4090504@gmail.com>
References: <1275561288-20661-1-git-send-email-l.fu@pengutronix.de>
	<4C1CE6B8.4090504@gmail.com>
Message-ID: <20100701105043.GB4092@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

On Sat, Jun 19, 2010 at 05:48:08PM +0200, Martin Fuzzey wrote:
> Hi Luotao,
> 
> Luotao Fu wrote:

....
> Your patch fixes the clock_disable problem but fbi->backlight_power()
> and fbi->lcd_power() can still be called multiple times.
> Not sure if that is really a problem - they should be idempotent.
> 
> I did it by making all of imxfb_disable_controller() do nothing if the
> disable was already done like this  (just for illustration not submission,
> lines may be mangled):
> 

Anything new on this? 'd be nice if you could resend a clean patch based
on the described you sent in this mail. There're about 3 Patches about
this issue out there. More might come in, as long as the bug still
exists. ;-) So let's pack it up and push a proper fix to Sascha.

cheers
Luotao Fu

-- 
Pengutronix e.K.                           | Dipl.-Ing. Luotao Fu        |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100701/6ed2ac84/attachment.sig>
