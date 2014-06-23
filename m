From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 23 Jun 2014 14:31:00 +0300
Subject: [PATCH] video: move Versatile CLCD helpers
In-Reply-To: <1401283017-15386-1-git-send-email-linus.walleij@linaro.org>
References: <1401283017-15386-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <53A80FF4.7030909@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/05/14 16:16, Linus Walleij wrote:
> This moves the Versatile-specific helper code and panel database
> down into the drivers/video folder next to the CLCD driver
> itself, preserving the config symbol but also moving the header
> to platform data.
> 
> This is necessary to rid the Integrator of this final <plat/*>
> inclusion dependency and get us one less user of the
> plat-versatile folder.

I don't like those display controller specific panel lookup tables at
all, but... Maybe it's still better to have them in the driver itself
instead of the arch/arm/.

I presume it's easier to queue this via arm tree, as it touches quite
many files there, and only adds a new file in video/.

So my (grudging) ack:

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140623/0f6ed766/attachment.sig>
