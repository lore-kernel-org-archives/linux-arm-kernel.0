From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 26 Nov 2013 09:31:25 -0700
Subject: [PATCH 16/31] ASoC: tegra: use reset framework
In-Reply-To: <20131126131410.GK14725@sirena.org.uk>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-17-git-send-email-swarren@wwwdotorg.org>
 <20131116095529.GF15393@sirena.org.uk> <528A4C8C.3030200@wwwdotorg.org>
 <20131118183716.GR2674@sirena.org.uk> <5293C787.1030005@wwwdotorg.org>
 <20131126131410.GK14725@sirena.org.uk>
Message-ID: <5294CCDD.30803@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2013 06:14 AM, Mark Brown wrote:
> On Mon, Nov 25, 2013 at 02:56:23PM -0700, Stephen Warren wrote:
> 
>> You didn't ack this one patch; I assume that was just an
>> oversight?
> 
> No, it was because it looked incorrect based on the lack of tie in 
> between the description and the code.

Hmm. You had asked:

>> @@ -1,6 +1,8 @@ config SND_SOC_TEGRA tristate "SoC Audio for the
>> Tegra System-on-Chip" depends on (ARCH_TEGRA && TEGRA20_APB_DMA)
>> || COMPILE_TEST +	depends on COMMON_CLK +	depends on
>> RESET_CONTROLLER
> 
> Do you depend on COMMON_CLK here?  I only noticed reset controller
> API dependencies here but perhaps I missed this (or it's fixing a
> dependency that should be there already).

I responded:

> It's fixing a dependency that should already be there, in the 
> COMPILE_TEST case. In the (ARCH_TEGRA && TEGRA20_APB_DMA) case, 
> COMMON_CLOCK is always selected.
> 
> Do you want me to split this out into a separate patch? If so, I'd 
> prefer not to apply that separate patch immediately to 3.13 as a
> fix, since then it'd delay applying this series until after -rc2 is
> out, unless you can get the fix into -rc1 quickly...

(although at this point in time, the DMA patches which this depend on
aren't likely to be ready soon enough for the delay to matter, so I
could send the addition of depends COMMON_CLK as a separate patch for
-rc2 if you want)

and you said:

> I don't really care, it was just that I was looking for something
> to do with clocks in the patch and couldn't find anything.  Perhaps
> a note in the changelog if you need to respin so I don't forget and
> say the same thing again.

... so, I thought you were OK with that one issue. Were there other
issues you didn't mention before?
