From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 18 Jul 2013 11:00:29 -0600
Subject: [PATCH] clk: tegra: depend on ARCH_TEGRA, not ARCH_TEGRA_*
In-Reply-To: <1374014039-22469-1-git-send-email-swarren@wwwdotorg.org>
References: <1374014039-22469-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <51E81F2D.6060405@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/2013 04:33 PM, Stephen Warren wrote:
> I'm planning to remove CONFIG_ARCH_TEGRA_*_SOC, leaving just ARCH_TEGRA.
> This will reduce the number of configurations that need to be supported
> by core Tegra code, e.g. CPU idle, hotplug. As a precursor, we need to
> update Kconfig for all Tegra drivers not to reference ARCH_TEGRA_*_SOC.
> 
> The Tegra clock driver contains a fairly large amount of SoC-specific
> code and data. Introduce explicit config options so that the user can
> trim the set of supported SoCs if they wish. Default these to on, since
> most people will probably want to enable support for all SoCs. This also
> avoids the need to change any defconfig files.

I'd like to defer actually applying this patch. There is some discussion
(in the thread for the equivalent ASoC patches) re: the best way to
handle the ARCH_TEGRA_*_SOC Kconfig options which might affect this
patch. Any review comment is still appreciated.
