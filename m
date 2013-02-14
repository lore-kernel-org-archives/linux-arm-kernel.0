From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Thu, 14 Feb 2013 15:07:01 +0200
Subject: [PATCH 5/9] USB: chipidea: add PTW and PTS handling
In-Reply-To: <1359984275-24646-6-git-send-email-s.hauer@pengutronix.de>
References: <1359984275-24646-1-git-send-email-s.hauer@pengutronix.de>
 <1359984275-24646-6-git-send-email-s.hauer@pengutronix.de>
Message-ID: <87txpf9h8q.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de> writes:

> From: Michael Grzeschik <m.grzeschik@pengutronix.de>
>
> This patch makes it possible to configure the PTW and PTS bits inside
> the portsc register for host and device mode before the driver starts
> and the phy can be addressed as hardware implementation is designed.
>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  .../devicetree/bindings/usb/ci13xxx-imx.txt        |    5 +++
>  drivers/usb/chipidea/bits.h                        |   14 ++++++-
>  drivers/usb/chipidea/ci13xxx_imx.c                 |    3 ++
>  drivers/usb/chipidea/core.c                        |   39 ++++++++++++++++++++
>  include/linux/usb/chipidea.h                       |    1 +
>  5 files changed, 61 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> index 5778b9c..dd42ccd 100644
> --- a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> +++ b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
> @@ -5,6 +5,11 @@ Required properties:
>  - reg: Should contain registers location and length
>  - interrupts: Should contain controller interrupt
>  
> +Recommended properies:
> +- phy_type: the type of the phy connected to the core. Should be one
> +  of "utmi", "utmi_wide", "ulpi", "serial" or "hsic". Without this
> +  property the PORTSC register won't be touched
> +

Looks like this bit belongs to patch 3/9, where you're adding devicetree
hooks. Otherwise looks good.

Regards,
--
Alex
