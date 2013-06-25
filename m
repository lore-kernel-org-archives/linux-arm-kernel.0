From: broonie@kernel.org (Mark Brown)
Date: Tue, 25 Jun 2013 10:26:12 +0100
Subject: [alsa-devel] [PATCH] ASoC: Tegra and i.MX are mutually exclusive
In-Reply-To: <51C93A62.1050702@metafoo.de>
References: <5967649.DUvDfofhX4@wuerfel>
 <51C93A62.1050702@metafoo.de>
Message-ID: <20130625092612.GX27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 08:36:18AM +0200, Lars-Peter Clausen wrote:

> It's just the ac97 drivers that are mutually exclusive. I'm not sure whether
> it makes sense to make the whole platforms mutually exclusive for this.

I agree, this is excessive and seems to rather defeat the point of
having multi-platform in the first place.  It makes it impossible to
build the sound drivers multi-platform all for the sake of a bus which
is used by approximately nothing these days (hence the lack of love the
code has had).

> Also this is not limited to tegra and imx. As more platforms are converted
> to multiplatform ARM the same issue will pop up for other platforms as well.
> I don't think your solution will scale really well for multiple platforms.
> The best solution would of course be to make AC97 work properly with
> multiple AC97 drivers. But maybe we can get away with a 'choice' Kconfig
> entry which allows you to select which platforms AC97 driver you want to build.

It should be easy enough to refactor so that we assign the ops pointer
when the driver is loaded instead of at link time which isn't solving
the issue but makes it better.  I'll send some patches.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130625/bfcd2a96/attachment.sig>
