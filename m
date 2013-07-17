From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 17 Jul 2013 12:23:03 -0600
Subject: [PATCH] ASoC: tegra: depend on ARCH_TEGRA, not ARCH_TEGRA_*
In-Reply-To: <20130717175701.GY22506@sirena.org.uk>
References: <1374013667-21435-1-git-send-email-swarren@wwwdotorg.org>
 <20130717083003.GA22506@sirena.org.uk> <51E6CDEA.7060003@wwwdotorg.org>
 <20130717175701.GY22506@sirena.org.uk>
Message-ID: <51E6E107.8020300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17/2013 11:57 AM, Mark Brown wrote:
> On Wed, Jul 17, 2013 at 11:01:30AM -0600, Stephen Warren wrote:
>> On 07/17/2013 02:30 AM, Mark Brown wrote:
> 
>> -       select SND_SOC_TEGRA20_I2S if ARCH_TEGRA_2x_SOC -
>> select SND_SOC_TEGRA30_I2S if ARCH_TEGRA_3x_SOC +       select
>> SND_SOC_TEGRA20_I2S +       select SND_SOC_TEGRA30_I2S
> 
>> But then, it won't be possible to disable support for older
>> SoCs, since simply enabling a machine driver that might support
>> Tegra20 would force ASoC support for Tegra20 to be enabled, even
>> if the user only cares about Tegra30.
> 
> So how do they disable the core support for the older SoCs with the
> new model?

They don't; the core support is so small it's not worth having the
ifdefs in it; just a few K. As such, it seems simpler to just always
compile in the core support, and remove the need for all the ifdef
nests in mach-tegra/. The bulk of the differences are different
drivers for different chips.
