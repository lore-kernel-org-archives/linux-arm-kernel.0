From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 12 Apr 2012 18:09:24 +0100
Subject: [PATCH v2] pinctrl: implement pinctrl deferred probing
In-Reply-To: <1334133248-1452-1-git-send-email-linus.walleij@stericsson.com>
References: <1334133248-1452-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20120412170924.GA18049@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 10:34:08AM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> If drivers try to obtain pinctrl handles for a pin controller that
> has not yet registered to the subsystem, we need to be able to
> back out and retry with deferred probing. So let's return
> -EPROBE_DEFER whenever this location fails. Also downgrade the
> errors to info, maybe we will even set them to debug once the
> deferred probing is commonplace.

Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Note that the probe deferral code already has info level logs every time
it does anything so you'll probably have a hint from that when it kicks
into action.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120412/6687be35/attachment.sig>
