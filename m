From: bjorn.forsman@gmail.com (=?UTF-8?Q?Bj=C3=B8rn_Forsman?=)
Date: Sat, 15 Jan 2011 17:37:08 +0100
Subject: [PATCH v2] ARM: pxa: PalmZ72: Add OV9640 camera support
In-Reply-To: <1295054277-7879-1-git-send-email-marek.vasut@gmail.com>
References: <1295054277-7879-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <AANLkTimK=g3gbc913sz-nGV+gmJZsU3ESPWFP_7kQBMf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 15 January 2011 02:17, Marek Vasut <marek.vasut@gmail.com> wrote:
> Rework of patch from 2009:
> PalmZ72: Add support for OV9640 camera sensor
>
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
> v2: Use gpio_request_array()/gpio_free_array() array
>
> ?arch/arm/mach-pxa/include/mach/palmz72.h | ? ?5 +
> ?arch/arm/mach-pxa/palmz72.c ? ? ? ? ? ? ?| ?127 ++++++++++++++++++++++++++++++
> ?2 files changed, 132 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/include/mach/palmz72.h b/arch/arm/mach-pxa/include/mach/palmz72.h
> index 2bbcf70..0d4700a 100644
> --- a/arch/arm/mach-pxa/include/mach/palmz72.h
> +++ b/arch/arm/mach-pxa/include/mach/palmz72.h

[snip]

> +static int palmz72_camera_power(struct device *dev, int power)
> +{
> + ? ? ? gpio_set_value(GPIO_NR_PALMZ72_CAM_PWDN, !power);
> + ? ? ? mdelay(50);
> + ? ? ? return 0;
> +}
> +
> +static int palmz72_camera_reset(struct device *dev)
> +{
> + ? ? ? gpio_set_value(GPIO_NR_PALMZ72_CAM_RESET, 1);
> + ? ? ? mdelay(50);
> + ? ? ? gpio_set_value(GPIO_NR_PALMZ72_CAM_RESET, 0);
> + ? ? ? mdelay(50);
> + ? ? ? return 0;
> +}

(Sorry if these are stupid newbie-questions.)

Is the entire kernel blocked during the above mdelay()s or
just some kernel thread? (Or: will this add like 100ms or 150ms
to boot time?)

Can mdelay() be replaced with something non-blocking?

[snip]

Best regards,
Bj?rn Forsman
