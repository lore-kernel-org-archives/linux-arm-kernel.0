From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 3 Jan 2017 18:59:20 +0200
Subject: [PATCH 2/4] input: tm2-touchkey: Add touchkey driver support for
 TM2
In-Reply-To: <1483430237-26823-3-git-send-email-jcsing.lee@samsung.com>
References: <1483430237-26823-1-git-send-email-jcsing.lee@samsung.com>
 <CGME20170103075733epcas5p4a065198d4abf35081024af95055c67d2@epcas5p4.samsung.com>
 <1483430237-26823-3-git-send-email-jcsing.lee@samsung.com>
Message-ID: <20170103165920.4tmpr3skgzb2dfah@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 03, 2017 at 04:57:15PM +0900, Jaechul Lee wrote:
> This patch adds support for the TM2 touch key and led
> functionlity.
> 
> The driver interfaces with userspace through an input device and
> reports KEY_PHONE and KEY_BACK event types. LED brightness can be
> controlled by "/sys/class/leds/tm2-touchkey/brightness".
> 
> Signed-off-by: Jaechul Lee <jcsing.lee@samsung.com>
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> ---
>  drivers/input/keyboard/Kconfig        |  11 ++
>  drivers/input/keyboard/Makefile       |   1 +
>  drivers/input/keyboard/tm2-touchkey.c | 326 ++++++++++++++++++++++++++++++++++
>  3 files changed, 338 insertions(+)
>  create mode 100644 drivers/input/keyboard/tm2-touchkey.c
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index cbd75cf..72c0ba1 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -666,6 +666,17 @@ config KEYBOARD_TC3589X
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called tc3589x-keypad.
>  
> +config KEYBOARD_TM2_TOUCHKEY
> +	tristate "tm2-touchkey support"
> +	depends on I2C
> +	help
> +	  Say Y here to enable the tm2-touchkey.

The ending full stop is not needed.

> +	  touchkey driver for tm2. This driver can enable
> +	  the interrupt and make input events and control led brightness.

This sentence needs improvements. How about just:
"Beside input device, this driver provides also brightness control for
LEDs on touch keys."

Best regards,
Krzysztof
