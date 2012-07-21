From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 21 Jul 2012 16:37:09 +0800
Subject: [alsa-devel] [PATCH 3/4] ASoC: sgtl5000: remove unneeded
 snd_soc_dapm_new_widgets in probe
In-Reply-To: <1342776027-31758-4-git-send-email-b29396@freescale.com>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
 <1342776027-31758-4-git-send-email-b29396@freescale.com>
Message-ID: <20120721083707.GD923@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2012 at 05:20:26PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> There's a driver bug that sgtl5000 dapm widget kcontrols do not work.
> e.g. can not select capture mux with amixer tool(no error info prompted).
> 
> The root cause is that we still call snd_soc_dapm_new_widgets in
> codec driver probe function afer converting to table based widgets.
> This will cause the card dapm widgets are instantiated before the
> dapm_routes are registered.
> Then, no available dapm widget pathes can be found during instantiation
> which finally will cause soc_dapm_mux_update_power to fail(can not find
> correct path with kcontrol) in snd_soc_dapm_put_enum_double function.
> 
> Here we remove the unneeded snd_soc_dapm_new_widgets in codec probe
> and let the soc core to handle the register sequence properly.
> Then we can fix above issue.
> 
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>

On imx53-qsb board:

Tested-by: Shawn Guo <shawn.guo@linaro.org>
