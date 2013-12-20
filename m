From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 20 Dec 2013 12:14:42 +0100
Subject: [PATCH 01/10] ARM: tegra: Add AS3722 PMIC on Venice2
In-Reply-To: <52B3695D.70601@wwwdotorg.org>
References: <1387469182-14398-1-git-send-email-treding@nvidia.com>
 <1387469182-14398-2-git-send-email-treding@nvidia.com>
 <52B3695D.70601@wwwdotorg.org>
Message-ID: <20131220111442.GK27787@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 02:47:09PM -0700, Stephen Warren wrote:
> On 12/19/2013 09:06 AM, Thierry Reding wrote:
> > This also adds the vmmc-supply property to the SDMMC node on Venice2.
> > Otherwise the core will turn the regulator off automatically because it
> > is unused.
> 
> Note: If I revert Laxman's "" and apply your patches 01/10 and 02/10 in
> its place, then I see the following during boot, and audio playback
> doesn't work any more:
> 
> > [   14.768649] max98090 0-0010: ASoC: Right Receiver Mixer DAPM update failed: -121
> > [   14.776715] max98090 0-0010: ASoC: Left Receiver Mixer DAPM update failed: -121
> > [   14.784601] max98090 0-0010: ASoC: Right Speaker Mixer DAPM update failed: -121
> > [   14.792602] max98090 0-0010: ASoC: Left Speaker Mixer DAPM update failed: -121
> > [   14.800423] max98090 0-0010: ASoC: Right Headphone Mixer DAPM update failed: -121
> > [   14.808655] max98090 0-0010: ASoC: Left Headphone Mixer DAPM update failed: -121
> > [   14.817628] max98090 0-0010: ASoC: Right ADC Mixer DAPM update failed: -121
> > [   14.825582] max98090 0-0010: ASoC: Left ADC Mixer DAPM update failed: -121

That's odd, I don't those errors in my local tree. When I try to play
back audio I do get this one:

	[  380.093679] max98090 0-0010: No audio clocks configured

But other than that everything seems to work fine. I don't hear anything
on the speakers or the headphones, but I'm likely missing the proper
mixer settings. Can you provide an asound.conf that works for you?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131220/63ea49d8/attachment-0001.sig>
