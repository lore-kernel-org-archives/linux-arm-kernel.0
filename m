From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 27 Sep 2012 07:56:36 +0200
Subject: [PATCH v4 1/2] watchdog: at91sam9_wdt: add device tree support
In-Reply-To: <1348568704-28304-2-git-send-email-fabio.porcedda@gmail.com>
References: <1348568704-28304-1-git-send-email-fabio.porcedda@gmail.com>
 <1348568704-28304-2-git-send-email-fabio.porcedda@gmail.com>
Message-ID: <20120927055636.GP17667@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12:25 Tue 25 Sep     , Fabio Porcedda wrote:
> Tested on an at91sam9260 board (evk-pro3)
> 
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> ---
>  .../devicetree/bindings/watchdog/atmel-wdt.txt      | 19 +++++++++++++++++++
>  drivers/watchdog/at91sam9_wdt.c                     | 21 +++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> new file mode 100644
> index 0000000..5947929
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> @@ -0,0 +1,19 @@
> +* Atmel Watchdog Timers
> +
> +** at91sam9-wdt
> +
> +Required properties:
> +- compatible: must be "atmel,at91sam9260-wdt".
> +- reg: physical base address of the controller and length of memory mapped
> +  region.
> +
> +Optional properties:
> +- heartbeat: contains the watchdog heartbeats in seconds.
more I read this binding more it's seems wrong

Today we do not use yet the watchdog framework which we will so we need to
use the same binding as the watchdog framework

So when we switch the DT will not change

Best Regards,
J.
