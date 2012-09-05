From: mgr@pengutronix.de (Michael Grzeschik)
Date: Wed, 5 Sep 2012 17:01:42 +0200
Subject: [PATCH v2 00/11] chipidea/imx: add otg support and some bug fix
In-Reply-To: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
References: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120905150142.GD4406@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2012 at 03:03:06PM +0800, Richard Zhao wrote:
> The patch set is tested on imx6q_sabrelite board.
> 
> The patch can also be found at
> https://github.com/riczhao/kernel-imx/commits/topics/usb-driver
> 
> For test which merged platform patches:
> https://github.com/riczhao/kernel-imx/commits/topics/usb-test
> 
> Changes since v1:
>  - move usbmisc as the other patch series.
>  - remove regulater_disable and old comments in ci13xxx_imx.
> 
> Richard Zhao (11):
>   USB: chipidea: imx: add pinctrl support
>   USB: chipidea: delay 2ms before read ID status at probe time
>   USB: chipidea: move OTGSC_IDIS clearing from ci_role_work to irq
>     handler
>   USB: chipidea: clear gadget struct at udc_start fail path
>   USB: chipidea: don't let probe fail if otg controller start one role
>     failed
>   USB: mxs-phy: add basic otg support
>   USB: chipidea: add vbus detect for udc
>   USB: chipidea: convert to use devm_request_irq
>   USB: chipidea: add -DDEBUG if CONFIG_USB_CHIPIDEA_DEBUG
>   USB: chipidea: add set_vbus_power support
>   USB: chipidea: re-order irq handling to avoid unhandled irq
> 
>  drivers/usb/chipidea/Makefile      |    2 ++
>  drivers/usb/chipidea/ci.h          |    1 +
>  drivers/usb/chipidea/ci13xxx_imx.c |   51 +++++++++++++++++++++++-------------
>  drivers/usb/chipidea/core.c        |   36 +++++++++++++++----------
>  drivers/usb/chipidea/host.c        |    8 ++++++
>  drivers/usb/chipidea/udc.c         |   40 +++++++++++++++++++++++++++-
>  drivers/usb/otg/mxs-phy.c          |   21 +++++++++++++++
>  include/linux/usb/chipidea.h       |    2 ++
>  8 files changed, 128 insertions(+), 33 deletions(-)

Tested-by: Michael Grzeschik <m.grzeschik@pengutronix.de>

To get this series applied, probably patch 04/11 and 05/11 should just
be dropped for now.

Michael
