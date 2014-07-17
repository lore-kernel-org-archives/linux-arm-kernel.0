From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 18 Jul 2014 00:31:48 +0200
Subject: [PATCH] ARM: config: update multi_v7_defconfig
In-Reply-To: <CAD=FV=UFknqF_Mt7ArytFq4KdDsGDa+JR2KZzX9Xn+if-_Vw4g@mail.gmail.com>
References: <1405411346-12471-1-git-send-email-ch.naveen@samsung.com>
 <CAD=FV=UFknqF_Mt7ArytFq4KdDsGDa+JR2KZzX9Xn+if-_Vw4g@mail.gmail.com>
Message-ID: <CABxcv==+cwoXA=WM3E7Zb62T0Epgqg_oH3UNU0vEe2DDPiCYPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Jul 15, 2014 at 5:59 PM, Doug Anderson <dianders@chromium.org> wrote:
>
> Is there a reason not to add more of the max77686 configs?
>
> +CONFIG_RTC_DRV_MAX77686=y
> +CONFIG_COMMON_CLK_MAX77686=y

AFAIK for the multi-platform defconfig we should try to build as a
module as many config options as possible to keep the kernel binary
size to a minimum.

In the case of the MAX77686, the mfd, regulator and clock drivers use
subsys_initcall() instead of module_init() but I wonder which of these
really need to be initialized at subsys init call time and which one
can just be built as a module. The only MAX77686 driver that uses
module_platform_driver() so it's initialized at device initcall time
is the rtc-max77686 driver which ironically is the only MAX77686
driver that doesn't define a MODULE_DEVICE_TABLE() so the module won't
be autoloaded.

Best regards,
Javier
