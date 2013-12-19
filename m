From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 19 Dec 2013 14:47:09 -0700
Subject: [PATCH 01/10] ARM: tegra: Add AS3722 PMIC on Venice2
In-Reply-To: <1387469182-14398-2-git-send-email-treding@nvidia.com>
References: <1387469182-14398-1-git-send-email-treding@nvidia.com>
 <1387469182-14398-2-git-send-email-treding@nvidia.com>
Message-ID: <52B3695D.70601@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/19/2013 09:06 AM, Thierry Reding wrote:
> This also adds the vmmc-supply property to the SDMMC node on Venice2.
> Otherwise the core will turn the regulator off automatically because it
> is unused.

Note: If I revert Laxman's "" and apply your patches 01/10 and 02/10 in
its place, then I see the following during boot, and audio playback
doesn't work any more:

> [   14.768649] max98090 0-0010: ASoC: Right Receiver Mixer DAPM update failed: -121
> [   14.776715] max98090 0-0010: ASoC: Left Receiver Mixer DAPM update failed: -121
> [   14.784601] max98090 0-0010: ASoC: Right Speaker Mixer DAPM update failed: -121
> [   14.792602] max98090 0-0010: ASoC: Left Speaker Mixer DAPM update failed: -121
> [   14.800423] max98090 0-0010: ASoC: Right Headphone Mixer DAPM update failed: -121
> [   14.808655] max98090 0-0010: ASoC: Left Headphone Mixer DAPM update failed: -121
> [   14.817628] max98090 0-0010: ASoC: Right ADC Mixer DAPM update failed: -121
> [   14.825582] max98090 0-0010: ASoC: Left ADC Mixer DAPM update failed: -121
