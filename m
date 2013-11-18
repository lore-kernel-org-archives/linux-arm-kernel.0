From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 18 Nov 2013 15:06:20 +0200
Subject: [PATCH 3/5] ARM: OMAP2+: Add DT init code for DPI displays and
 make omap3 LDP to use it
In-Reply-To: <1384562167-14725-4-git-send-email-tony@atomide.com>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
 <1384562167-14725-4-git-send-email-tony@atomide.com>
Message-ID: <528A10CC.7070908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-11-16 02:36, Tony Lindgren wrote:
> In order to make the remaining omap3 boards usable with device
> tree, we need to initialize the DPI based displays using pdata
> until we have the DSS bindings in place.
> 
> At least board-am3517evm.c, board-cm-t35.c, board-devkit8000.c,
> board-ldp.c and board-overo.c all use fairly similar DPI setup,
> so let's add generic code for it. And let's make omap3 LDP to
> use it and also initialize the ads7846 until we have a binding
> for it.
> 
> Note that at least LDP needs the TWL bug fix posted as
> "gpio: twl4030: Fix regression for twl gpio output" for the
> LCD backlight to power.

Looks fine to me.

Is it possible to keep this, and other similar DSS patches, in a
separate branch, that could be dropped if needed? I'm kind of hoping I
would get the DSS DT finished for the next merge window (but I've said
that before, so...).

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131118/c02ffb77/attachment.sig>
