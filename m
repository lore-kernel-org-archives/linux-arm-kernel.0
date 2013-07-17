From: broonie@kernel.org (Mark Brown)
Date: Wed, 17 Jul 2013 18:57:01 +0100
Subject: [PATCH] ASoC: tegra: depend on ARCH_TEGRA, not ARCH_TEGRA_*
In-Reply-To: <51E6CDEA.7060003@wwwdotorg.org>
References: <1374013667-21435-1-git-send-email-swarren@wwwdotorg.org>
 <20130717083003.GA22506@sirena.org.uk>
 <51E6CDEA.7060003@wwwdotorg.org>
Message-ID: <20130717175701.GY22506@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 11:01:30AM -0600, Stephen Warren wrote:
> On 07/17/2013 02:30 AM, Mark Brown wrote:

> -       select SND_SOC_TEGRA20_I2S if ARCH_TEGRA_2x_SOC
> -       select SND_SOC_TEGRA30_I2S if ARCH_TEGRA_3x_SOC
> +       select SND_SOC_TEGRA20_I2S
> +       select SND_SOC_TEGRA30_I2S

> But then, it won't be possible to disable support for older SoCs,
> since simply enabling a machine driver that might support Tegra20
> would force ASoC support for Tegra20 to be enabled, even if the user
> only cares about Tegra30.

So how do they disable the core support for the older SoCs with the new
model?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130717/c1e3788a/attachment.sig>
