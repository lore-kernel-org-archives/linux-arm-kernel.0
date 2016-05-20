From: carlo@caione.org (Carlo Caione)
Date: Fri, 20 May 2016 12:04:37 +0200
Subject: [PATCH 1/3] reset: Add support for the Amlogic Meson GXBB Reset
 Controller
In-Reply-To: <573ED483.10101@baylibre.com>
References: <1463732875-23141-1-git-send-email-narmstrong@baylibre.com>
 <1463732875-23141-2-git-send-email-narmstrong@baylibre.com>
 <20160520090448.GA19888@mephisto> <573ED483.10101@baylibre.com>
Message-ID: <20160520100437.GA21213@mephisto>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/05/16 11:10, Neil Armstrong wrote:
> On 05/20/2016 11:04 AM, Carlo Caione wrote:
> > On 20/05/16 10:27, Neil Armstrong wrote:
> >> This patch adds the platform driver for the Amlogic Meson GXBB Reset
> >> Controller.
> >>
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >> ---
> >>  drivers/reset/Kconfig            |   6 ++
> >>  drivers/reset/Makefile           |   1 +
> >>  drivers/reset/reset-meson-gxbb.c | 129 +++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 136 insertions(+)
> >>  create mode 100644 drivers/reset/reset-meson-gxbb.c
> > 
> > Do we really need to be that specific (-gxbb)? This driver looks generic
> > and simple enough to be used for several Amlogic families. You are
> > already differentiating between them with the include file defining the
> > reset indexes for the SoC.
> 
> This is a good question, do the S805 have similar registers ? Same count and width ?
> I no, it should need a rework to add a data structure per-SoC.

According to the datasheet on S805 we have 7 registers with 16 reset
bits per register.

[...]
> > 
> > [...]
> >> +static struct platform_driver meson_gxbb_reset_driver = {
> >> +	.probe	= meson_gxbb_reset_probe,
> >> +	.remove	= meson_gxbb_reset_remove,
> >> +	.driver = {
> >> +		.name		= "meson_gxbb_reset",
> >> +		.of_match_table	= meson_gxbb_reset_dt_ids,
> >> +	},
> >> +};
> >> +
> >> +module_platform_driver(meson_gxbb_reset_driver);
> > 
> > No MODULE_AUTHOR, MODULE_LICENSE, etc... ?
> 
> What is the MODULE_LICENCE format for dual licensing ?

Dual BSD/GPL ?

Cheers,

-- 
Carlo Caione
