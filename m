From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 18 Nov 2013 10:21:16 -0700
Subject: [PATCH 16/31] ASoC: tegra: use reset framework
In-Reply-To: <20131116095529.GF15393@sirena.org.uk>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-17-git-send-email-swarren@wwwdotorg.org>
 <20131116095529.GF15393@sirena.org.uk>
Message-ID: <528A4C8C.3030200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2013 02:55 AM, Mark Brown wrote:
> On Fri, Nov 15, 2013 at 01:54:11PM -0700, Stephen Warren wrote:
> 
>> @@ -1,6 +1,8 @@ config SND_SOC_TEGRA tristate "SoC Audio for the
>> Tegra System-on-Chip" depends on (ARCH_TEGRA && TEGRA20_APB_DMA)
>> || COMPILE_TEST +	depends on COMMON_CLK +	depends on
>> RESET_CONTROLLER
> 
> Do you depend on COMMON_CLK here?  I only noticed reset controller
> API dependencies here but perhaps I missed this (or it's fixing a
> dependency that should be there already).

It's fixing a dependency that should already be there, in the
COMPILE_TEST case. In the (ARCH_TEGRA && TEGRA20_APB_DMA) case,
COMMON_CLOCK is always selected.

Do you want me to split this out into a separate patch? If so, I'd
prefer not to apply that separate patch immediately to 3.13 as a fix,
since then it'd delay applying this series until after -rc2 is out,
unless you can get the fix into -rc1 quickly...
