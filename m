From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 13 Feb 2018 15:51:33 +0100
Subject: [PATCH 2/2] clk: meson-axg: Add AO Clock and Reset controller
 driver
In-Reply-To: <1518449571.2883.30.camel@baylibre.com>
References: <20180209070026.193879-1-yixun.lan@amlogic.com>
 <20180209070026.193879-3-yixun.lan@amlogic.com>
 <1518449571.2883.30.camel@baylibre.com>
Message-ID: <1518533493.2883.35.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-02-12 at 16:32 +0100, Jerome Brunet wrote:
> On Fri, 2018-02-09 at 15:00 +0800, Yixun Lan wrote:
> > Adds a Clock and Reset controller driver for the Always-On part
> > of the Amlogic Meson-AXG SoC.
> > 
> > Signed-off-by: Qiufang Dai <qiufang.dai@amlogic.com>
> > Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> > ---
> >   drivers/clk/meson/Makefile    |   2 +-
> >   drivers/clk/meson/axg-aoclk.c | 236 ++++++++++++++++++++++++++++++++++++++++++
> >   drivers/clk/meson/axg-aoclk.h |  25 +++++
> >   3 files changed, 262 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/clk/meson/axg-aoclk.c
> >   create mode 100644 drivers/clk/meson/axg-aoclk.h

Yixun,

Actually, looking at this driver further, except for some of the data, the
driver is exactly the same as gxbb-aoclk. There is no reason to duplicate all
this code.

I'd prefer if you'd factor all this in a dedicated driver.
This philosophy is more or less the same as meson's pinctrl drivers, which all
provides their own data and bindings but share the driver code.

Regards
Jerome
