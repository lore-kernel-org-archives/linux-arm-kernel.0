From: broonie@kernel.org (Mark Brown)
Date: Wed, 17 Jul 2013 09:30:03 +0100
Subject: [PATCH] ASoC: tegra: depend on ARCH_TEGRA, not ARCH_TEGRA_*
In-Reply-To: <1374013667-21435-1-git-send-email-swarren@wwwdotorg.org>
References: <1374013667-21435-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130717083003.GA22506@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 16, 2013 at 04:27:47PM -0600, Stephen Warren wrote:

> Stop selecting I2S/AC97/SPDIF controller drivers from the machine driver
> config options; this doesn't really work if we don't know which specific
> SoC(s) we're building for. However, set their default values based on
> SND_SOC_TEGRA, since most people will probably want to enable support for
> all SoCs. This also avoids the need to change any defconfig files.

This doesn't seem terribly clever and is definitely not idiomatic for
ASoC.  If you want to just select all CPUs that'd be fine but forcing
the user to select the individual components isn't the style anything
else uses.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130717/400e5d30/attachment-0001.sig>
