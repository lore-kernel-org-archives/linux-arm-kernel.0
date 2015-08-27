From: ryabinin.a.a@gmail.com (Andrey Ryabinin)
Date: Thu, 27 Aug 2015 15:20:34 +0300
Subject: [PATCH] rtc: Fix module autoload for rtc-{ab8500, max8997,
 s5m} drivers
In-Reply-To: <1440671672-26590-1-git-send-email-javier@osg.samsung.com>
References: <1440671672-26590-1-git-send-email-javier@osg.samsung.com>
Message-ID: <CAPAsAGyrEm--=WfGB4wSFSXE8HZpp+HDuV=p4JmFbV-X2keQCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-08-27 13:34 GMT+03:00 Javier Martinez Canillas <javier@osg.samsung.com>:
> These platform drivers have a platform device ID table but the module
> alias information is not created so module autoloading will not work.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>
> ---
>
>  drivers/rtc/rtc-ab8500.c  | 1 +
>  drivers/rtc/rtc-max8997.c | 1 +
>  drivers/rtc/rtc-s5m.c     | 1 +
>  3 files changed, 3 insertions(+)
>
> diff --git a/drivers/rtc/rtc-ab8500.c b/drivers/rtc/rtc-ab8500.c
> index 133d2e2e1a25..8537d1e3a995 100644
> --- a/drivers/rtc/rtc-ab8500.c
> +++ b/drivers/rtc/rtc-ab8500.c
> @@ -446,6 +446,7 @@ static const struct platform_device_id ab85xx_rtc_ids[] = {
>         { "ab8500-rtc", (kernel_ulong_t)&ab8500_rtc_ops, },
>         { "ab8540-rtc", (kernel_ulong_t)&ab8540_rtc_ops, },

Completely irrelevant, but this array should have an empty terminating element.

>  };
> +MODULE_DEVICE_TABLE(platform, ab85xx_rtc_ids);
>
