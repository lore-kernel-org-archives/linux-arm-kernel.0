From: broonie@kernel.org (Mark Brown)
Date: Sat, 27 Jul 2013 13:05:22 +0100
Subject: [PATCH v10 1/7] ASoC: core: Generic ac97 link reset functions
In-Reply-To: <1374924716-23475-2-git-send-email-mpa@pengutronix.de>
References: <1374924716-23475-1-git-send-email-mpa@pengutronix.de>
 <1374924716-23475-2-git-send-email-mpa@pengutronix.de>
Message-ID: <20130727120522.GG9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 27, 2013 at 01:31:50PM +0200, Markus Pargmann wrote:

This is a really nice approach to the problem, just one thing I'd like
to see changed in the bindings:

> +ssi {
> +	...
> +
> +	pinctrl-names = "default", "ac97-running", "ac97-reset", "ac97-warm-reset";

I'd like to see some documentation of this "default" state - I'd expect
this corresponds to the bus being idle and waiting for a wakeup from the
CODEC which is definitely a useful state to have for power optimisation
so it'd be good to bake it into the bindings.

Alternatively it could be the bus being totally idle with no possibility
of wakeup in which case it'd be good to say that too then someone can
add the waiting for wakeup state later.

Please also note the new list devicetree at vger.kernel.org.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130727/39a1016c/attachment.sig>
