From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 02 Feb 2015 14:08:36 -0700
Subject: [PATCH v3 01/10] ARM: tegra: Set the sound card model that alsaucm
 expects
In-Reply-To: <1422442278-10405-2-git-send-email-tomeu.vizoso@collabora.com>
References: <1422442278-10405-1-git-send-email-tomeu.vizoso@collabora.com>
 <1422442278-10405-2-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <54CFE754.7000500@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2015 03:50 AM, Tomeu Vizoso wrote:
> Patches are on its way to add a config file to alsaucm for the Nyan
> boards. Use the same card ID that alsaucm will expect.

> diff --git a/arch/arm/boot/dts/tegra124-nyan-big.dts b/arch/arm/boot/dts/tegra124-nyan-big.dts

>   	sound {
> -		compatible = "nvidia,tegra-audio-max98090-nyan-big",
> +		compatible = "nvidia,tegra-audio-max98090-nyan",
>   			     "nvidia,tegra-audio-max98090";

I'm not convinced that removing the board-specific compatible value is a 
great idea. What if we find we need to distinguish between different 
boards that use this same binding in the future. That situation is 
exactly why we have board-/SoC-specific values in compatible even if we 
don't immediately use them.

> -		nvidia,model = "Acer Chromebook 13";
> +		nvidia,model = "GoogleNyan";

I believe this also technically breaks ABI, since some user-space tools 
use the model to look up saved state. Can we not leave this as is, and 
just have the UCM files know about both names?

Aside from that, I think the series looks OK at a quick glance.
