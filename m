From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 07 Jun 2013 10:53:38 -0600
Subject: [PATCH 2/3] clk: tegra: T114: add DFLL source clocks
In-Reply-To: <20130607121858.21868.73882.stgit@dusk.lan>
References: <20130607121505.21868.72360.stgit@dusk.lan>
 <20130607121858.21868.73882.stgit@dusk.lan>
Message-ID: <51B21012.2030302@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2013 06:19 AM, Paul Walmsley wrote:
> Add the input clocks needed by the DFLL IP blocks.  Initialize them to
> 51MHz (as required by the DFLL GFD) and to use the PLL_P clock source.
> 
> This patch is a collaboration with Peter De Schrijver
> <pdeschrijver@nvidia.com>.
> 
> Thanks to Laxman Dewangan <ldewangan@nvidia.com> for identifying the
> requirement to keep the DFLL clocks enabled to resolve PWR_I2C timeout
> issues.

> diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c

> @@ -792,6 +794,7 @@ enum tegra114_clk {
>  	audio1, audio2, audio3, audio4, spdif, clk_out_1, clk_out_2, clk_out_3,
>  	blink, xusb_host_src = 252, xusb_falcon_src, xusb_fs_src, xusb_ss_src,
>  	xusb_dev_src, xusb_dev, xusb_hs_src, sclk, hclk, pclk, cclk_g, cclk_lp,
> +	dfll_ref = 264, dfll_soc,

Those values need to be added to the DT binding documentation, or rather
the header file that now defines the constants for that binding.

BTW, I was rather hoping that Hiroshi would have converted the clock
drivers to actually use that header file by now... Then this requirement
would have been a lot more obvious. Hiroshi, are patches for that coming
soon? Paul, if not, are you able to do that?

For reference, include/dt-bindings/clock/tegra*-car.h.
