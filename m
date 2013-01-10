From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 Jan 2013 14:56:25 +0800
Subject: [RFC PATCH 1/5] ARM i.MX6q: Add GPU, VPU, IPU, and OpenVG resets
 to system reset controller
In-Reply-To: <1357751839-19680-2-git-send-email-p.zabel@pengutronix.de>
References: <1357751839-19680-1-git-send-email-p.zabel@pengutronix.de>
 <1357751839-19680-2-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130110065622.GA7466@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Wed, Jan 09, 2013 at 06:17:15PM +0100, Philipp Zabel wrote:
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  .../devicetree/bindings/reset/fsl,imx-src.txt      |   45 ++++++++++++++++++++
>  arch/arm/mach-imx/src.c                            |   41 ++++++++++++++++++
>  include/linux/imx-src.h                            |    6 +++
>  3 files changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/fsl,imx-src.txt
>  create mode 100644 include/linux/imx-src.h

I'm with Stephen that we should try to create a common API for this.
Instead of ask device drivers to call IMX specific imx_src_reset(),
we should have them call some type of common API with struct device
as the argument.  And the work of calling of_parse_phandle_with_args()
should be done inside the API.  It's pointless to ask every single
client driver to do this same work.

Shawn
