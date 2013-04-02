From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 02 Apr 2013 13:58:41 -0600
Subject: [PATCH V5 7/9] ARM: dts: tegra: add non-removable and
 keep-power-in-suspend property for MMC
In-Reply-To: <1364901613-25080-8-git-send-email-josephl@nvidia.com>
References: <1364901613-25080-1-git-send-email-josephl@nvidia.com>
 <1364901613-25080-8-git-send-email-josephl@nvidia.com>
Message-ID: <515B3871.50801@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/02/2013 05:20 AM, Joseph Lo wrote:
> This patch adds "non-removable" property of MMC host where the eMMC device
> is for Tegra platform.
> 
> And the "keep-power-in-suspend" property was used for the SDIO device that
> need this to go into suspend mode (e.g. BRCM43xx series).

>  arch/arm/boot/dts/tegra20-paz00.dts      | 1 +
>  arch/arm/boot/dts/tegra20-seaboard.dts   | 2 ++
>  arch/arm/boot/dts/tegra20-ventana.dts    | 2 ++
>  arch/arm/boot/dts/tegra20-whistler.dts   | 1 +
>  arch/arm/boot/dts/tegra30-beaver.dts     | 1 +
>  arch/arm/boot/dts/tegra30-cardhu-a02.dts | 1 +
>  arch/arm/boot/dts/tegra30-cardhu-a04.dts | 1 +
>  arch/arm/boot/dts/tegra30-cardhu.dtsi    | 1 +

I think there are a bunch of other boards that need a similar change,
right? There are certainly eMMC devices on other boards, and shouldn't
they be marked with non-removable? In particular, Beaver, Dalmore, and
Pluto, and likely some/all of the Colibri and Avionic Design boards. I
think it should be obvious which SDHCI devices need this, since there
won't be any cd-gpios property and the bus-width will likely be 8.
