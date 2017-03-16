From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 16 Mar 2017 22:53:31 +0100
Subject: [PATCH] ARM: imx5x: register SOC device
In-Reply-To: <20170312105633.21168-1-kernel@esmil.dk>
References: <20170312105633.21168-1-kernel@esmil.dk>
Message-ID: <7043958.dJaacR2zaA@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, March 12, 2017 11:56:33 AM CET Emil Renner Berthing wrote:
> @@ -30,6 +30,13 @@ static void __init imx53_init_early(void)
>  
>  static void __init imx53_dt_init(void)
>  {
> +       struct device *parent = imx_soc_device_init();
> +
> +       if (!parent)
> +               pr_warn("failed to initialize soc device\n");
> +
> +       of_platform_default_populate(NULL, NULL, parent);
> +

When we started adding soc_device, the idea was to have all on-chip
devices under the soc node in sysfs. However, this has changed now,
and for new machines, we just use it for identification and don't
change the normal of_platform_populate() logic to use it as a root.

      Arnd
