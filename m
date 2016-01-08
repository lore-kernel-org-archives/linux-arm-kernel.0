From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 8 Jan 2016 12:00:13 -0300
Subject: [PATCH 1/2] power: act8945a: add charger driver for ACT8945A
In-Reply-To: <1452219225-10510-2-git-send-email-wenyou.yang@atmel.com>
References: <1452219225-10510-1-git-send-email-wenyou.yang@atmel.com>
 <1452219225-10510-2-git-send-email-wenyou.yang@atmel.com>
Message-ID: <CABxcv=mQoDxb7oHh0DdC_t1_m-j=4Hp-sPNoq4Apy4c7CneSng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wenyou,

On Thu, Jan 7, 2016 at 11:13 PM, Wenyou Yang <wenyou.yang@atmel.com> wrote:
> This patch adds new driver for Active-semi ACT8945A ActivePath
> charger (part of ACT8945A MFD driver) providing power supply class
> information to userspace.
>
> The driver is configured through DTS (battery and system related
> settings) and sysfs entries (timers and input over-voltage threshold).
>
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
>

[snip]

> +
> +static struct platform_driver act8945a_charger_driver = {
> +       .driver = {
> +               .name = "act8945a-charger",
> +       },
> +       .probe  = act8945a_charger_probe,
> +       .remove = act8945a_charger_remove,
> +};
> +

The driver is missing an OF match table (and also a platform ID match
table if non-DT is supported) so this means that module autoloading
will be broken for this driver since the platform uevent function will
report a MODALIAS=of:N*T*Cactive-semi,act8945a-charger

Matching is only working because the platform bus match function use
as a fallback the driver name.

Best regards,
Javier
