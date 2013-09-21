From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 21 Sep 2013 17:12:04 +0200
Subject: [PATCH 2/6] clk: exynos-audss: allow input clocks to be specified
 in device tree
In-Reply-To: <1379711637-5226-2-git-send-email-abrestic@chromium.org>
References: <1379711637-5226-1-git-send-email-abrestic@chromium.org>
 <1379711637-5226-2-git-send-email-abrestic@chromium.org>
Message-ID: <9856196.dhfL7qQoq1@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Friday 20 of September 2013 14:13:53 Andrew Bresticker wrote:
> This allows the input clocks to the Exynos AudioSS block to be
> specified via device-tree bindings.  Default names will be used
> when an input clock is not given.
[snip]
> +Optional Properties:
> +
> +- clocks:
> +  - pll_ref: Fixed rate PLL reference clock, parent of mout_audss.
> "fin_pll" +    is used if not specified.
> +  - pll_in: Input PLL to the AudioSS block, parent of mout_audss.
> "fout_epll" +    is used if not specified.
> +  - cdclk: External i2s clock, parent of mout_i2s. "cdclk0" is used if
> not +    specified.
> +  - sclk_audio: Audio bus clock, parent of mout_i2s. "sclk_audio0" is
> used if +    not specified.
> +  - sclk_pcm_in: PCM clock, parent of sclk_pcm.  "sclk_pcm0" is used if
> not +    specified.
> +
> +- clock-names: Aliases for the above clocks. They should be "pll_ref",
> +  "pll_in", "cdclk", "sclk_audio", and "sclk_pcm_in" respectively.

I'd say that it should be preferred to specify all the input clocks 
appropriate for particular SoCs to fully represent the hardware. So the 
properties above should be marked as required (depending on SoC probably).

The fallback to default names in the driver should stay, though, to 
support older device trees.

Best regards,
Tomasz
