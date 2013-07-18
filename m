From: broonie@kernel.org (Mark Brown)
Date: Thu, 18 Jul 2013 10:58:15 +0100
Subject: [PATCH] ASoC: tegra: depend on ARCH_TEGRA, not ARCH_TEGRA_*
In-Reply-To: <51E7203A.2020007@wwwdotorg.org>
References: <1374013667-21435-1-git-send-email-swarren@wwwdotorg.org>
 <20130717083003.GA22506@sirena.org.uk>
 <51E6CDEA.7060003@wwwdotorg.org>
 <20130717175701.GY22506@sirena.org.uk>
 <51E6E107.8020300@wwwdotorg.org>
 <20130717223309.GZ22506@sirena.org.uk>
 <51E7203A.2020007@wwwdotorg.org>
Message-ID: <20130718095815.GE22506@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 04:52:42PM -0600, Stephen Warren wrote:

> The key to enable tegra30_i2s.c should really be ARCH_TEGRA_3x_SOC ||
> ARCH_TEGRA_114_SOC, which gets a bit unwieldy once you have, say, 4
> different SoCs in that list and a similar list starts to apply to a
> lot of different HW-modules/drivers. Even creating an
> ARCH_TEGRA_30_OR_LATER_SOC will get problematic, since defining "or
> later" will likely become progressively more complex over time, as we
> start putting our more SoCs. What are your thoughts on the best way to
> solve that?

Can't you just say Tegra 20 or later is Tegra 20 plus Tegra 30 or later
and so on?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130718/0307c9f5/attachment.sig>
