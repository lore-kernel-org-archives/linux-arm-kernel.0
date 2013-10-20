From: broonie@kernel.org (Mark Brown)
Date: Sun, 20 Oct 2013 17:33:26 +0100
Subject: [PATCH v3 2/2] ASoC: kirkwood: fix loss of external clock at
 probe time
In-Reply-To: <20131020080333.GG10079@pengutronix.de>
References: <20131018203555.4d974251@armhf>
 <20131018191259.GF10079@pengutronix.de>
 <20131019102809.180dc4ff@armhf>
 <20131020080333.GG10079@pengutronix.de>
Message-ID: <20131020163326.GN2443@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 20, 2013 at 10:03:33AM +0200, Uwe Kleine-K?nig wrote:

> Yes, that's understood. My suggestion behaves as your's for the return
> values -EPROBE_DEFER and -ENOENT, so the deferred probe should work,
> too. The question is only what you want to do for other errors (don't
> know if they can happen at this stage). I'd say, on a dt parsing error
> bail out, too.

It seems like the best thing to do is defer if the error might resolve
itself but otherwise carry on with the reduced functionality from the
internal clocks.  I'd expect most errors to be permanently fatal though,
certainly a failure to parse the DT is unlikely to get fixed at runtime.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131020/00801e71/attachment.sig>
