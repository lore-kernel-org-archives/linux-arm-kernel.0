From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Oct 2015 10:44:35 +0100
Subject: [PATCH] ASoC: sun4i-codec: Rework and fix headphone routing
In-Reply-To: <1443965896-6205-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1443965896-6205-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20151005094435.GI12635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 04, 2015 at 03:38:16PM +0200, Maxime Ripard wrote:

> Most of the boards have their headphone jack directly connected to the
> matching pins of the SoCs. Since most of the time we will have the same
> routing path, it makes sense to put that in the driver, and only have a
> property describing whether that route is enabled or not.

What is the value in having just a dumb jack with no detection
configured?  It doesn't actually do anything...

> It also fixes the following warning messages that were seen so far:
> sun4i-codec 1c22c00.codec: ASoC: no sink widget found for Headphone Jack
> sun4i-codec 1c22c00.codec: ASoC: Failed to add route HP Left -> direct -> Headphone Jack
> sun4i-codec 1c22c00.codec: ASoC: no sink widget found for Headphone Jack
> sun4i-codec 1c22c00.codec: ASoC: Failed to add route HP Right -> direct -> Headphone Jack

Why are these routes being added separately to adding the jack?  Just
remove the broken routes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151005/76906a95/attachment.sig>
