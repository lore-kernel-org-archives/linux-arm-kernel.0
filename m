From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 20 Dec 2013 10:02:38 -0700
Subject: [PATCH 01/10] ARM: tegra: Add AS3722 PMIC on Venice2
In-Reply-To: <20131220111442.GK27787@ulmo.nvidia.com>
References: <1387469182-14398-1-git-send-email-treding@nvidia.com>
 <1387469182-14398-2-git-send-email-treding@nvidia.com>
 <52B3695D.70601@wwwdotorg.org> <20131220111442.GK27787@ulmo.nvidia.com>
Message-ID: <52B4782E.8060904@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/2013 04:14 AM, Thierry Reding wrote:
> On Thu, Dec 19, 2013 at 02:47:09PM -0700, Stephen Warren wrote:
>> On 12/19/2013 09:06 AM, Thierry Reding wrote:
>>> This also adds the vmmc-supply property to the SDMMC node on Venice2.
>>> Otherwise the core will turn the regulator off automatically because it
>>> is unused.
>>
>> Note: If I revert Laxman's "" and apply your patches 01/10 and 02/10 in
>> its place, then I see the following during boot, and audio playback
>> doesn't work any more:
>>
>>> [   14.768649] max98090 0-0010: ASoC: Right Receiver Mixer DAPM update failed: -121
>>> [   14.776715] max98090 0-0010: ASoC: Left Receiver Mixer DAPM update failed: -121
>>> [   14.784601] max98090 0-0010: ASoC: Right Speaker Mixer DAPM update failed: -121
>>> [   14.792602] max98090 0-0010: ASoC: Left Speaker Mixer DAPM update failed: -121
>>> [   14.800423] max98090 0-0010: ASoC: Right Headphone Mixer DAPM update failed: -121
>>> [   14.808655] max98090 0-0010: ASoC: Left Headphone Mixer DAPM update failed: -121
>>> [   14.817628] max98090 0-0010: ASoC: Right ADC Mixer DAPM update failed: -121
>>> [   14.825582] max98090 0-0010: ASoC: Left ADC Mixer DAPM update failed: -121
> 
> That's odd, I don't those errors in my local tree. When I try to play
> back audio I do get this one:
> 
> 	[  380.093679] max98090 0-0010: No audio clocks configured

I do see that too. In practice it's harmless since audio does work, and
I /think/ it's really a false startup-condition error from the CODEC
driver, but I need to investigate it sometime.

> But other than that everything seems to work fine. I don't hear anything
> on the speakers or the headphones, but I'm likely missing the proper
> mixer settings. Can you provide an asound.conf that works for you?

Yes, you will need to configure the mixer. Our internal kernel testing
wiki page has asound.state attached. I'll send you a link to that
internally.
