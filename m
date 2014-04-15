From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 Apr 2014 12:31:25 -0600
Subject: [PATCH 4/4] ARM: tegra: fix Venice2 VQMMC regulators
In-Reply-To: <1397526163-20126-5-git-send-email-abrestic@chromium.org>
References: <1397526163-20126-1-git-send-email-abrestic@chromium.org>
 <1397526163-20126-5-git-send-email-abrestic@chromium.org>
Message-ID: <534D7AFD.7080807@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14/2014 07:42 PM, Andrew Bresticker wrote:
> VDDIO_SDMMC3 is the VQMMC supply, not the VMMC supply, for the SD
> slot.  Add 1.8V_VDDIO as the VQMMC supply for the eMMC.

Is there documentation re: what vmmc-supply and vqmmc-supply actually
refer to? I looked a long while ago and couldn't find any, and didn't
get an answer when I asked.

Neither
Documentation/devicetree/bindings/mmc/{mmc.txt,nvidia,tegra20-sdhci.txt}
seem to say:-(
