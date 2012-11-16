From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 16 Nov 2012 14:45:39 +0200
Subject: [PATCH 6/9] usb: chipidea: add PTW and PTS handling
In-Reply-To: <1352909950-32555-7-git-send-email-m.grzeschik@pengutronix.de>
References: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352909950-32555-7-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <87zk2h67ik.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Grzeschik <m.grzeschik@pengutronix.de> writes:

> This patch makes it possible to configure the PTW and PTS bits inside
> the portsc register for host and device mode before the driver starts
> and the phy can be addressed as hardware implementation is designed.
>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/usb/chipidea/bits.h        |    3 +++
>  drivers/usb/chipidea/ci.h          |    2 ++
>  drivers/usb/chipidea/ci13xxx_imx.c |    1 +
>  drivers/usb/chipidea/core.c        |   47 ++++++++++++++++++++++++++++++++++++
>  drivers/usb/chipidea/host.c        |    4 +++
>  include/linux/usb/chipidea.h       |    9 +++++++
>  6 files changed, 66 insertions(+)
>
> diff --git a/drivers/usb/chipidea/bits.h b/drivers/usb/chipidea/bits.h
> index 4b6ae3e..3cded5f 100644
> --- a/drivers/usb/chipidea/bits.h
> +++ b/drivers/usb/chipidea/bits.h
> @@ -48,6 +48,9 @@
>  #define PORTSC_SUSP           BIT(7)
>  #define PORTSC_HSP            BIT(9)
>  #define PORTSC_PTC            (0x0FUL << 16)
> +#define PORTSC_PTS            (BIT(31) | BIT(30))
> +#define PORTSC_PTW            BIT(28)
> +#define PORTSC_STS            BIT(29)

Hm, my spec says these are actually in DEVLC register and only have this
meaning in device mode. And in portsc these bits fall in device address
bitfield. Can you refer me to your spec?

Regards,
--
Alex
