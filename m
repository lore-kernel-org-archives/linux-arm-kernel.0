From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Jul 2014 15:04:49 +0200
Subject: [PATCH v5 5/8] power: reset: move hisilicon reboot code
In-Reply-To: <1406551883-26154-6-git-send-email-haojian.zhuang@linaro.org>
References: <1406551883-26154-1-git-send-email-haojian.zhuang@linaro.org>
 <1406551883-26154-6-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <5372764.rLStIIsI33@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 July 2014 20:51:20 Haojian Zhuang wrote:
> +
> +static struct of_device_id hisi_reboot_of_match[] = {
> +       { .compatible = "hisilicon,sysctrl" },
> +       {}
> +};
> +
> +static struct platform_driver hisi_reboot_driver = {
> +       .probe = hisi_reboot_probe,
> +       .driver = {
> +               .name = "hisi-reboot",
> +               .of_match_table = hisi_reboot_of_match,
> +       },
> +};
> +module_platform_driver(hisi_reboot_driver);

I think this will get you into trouble if anything else starts
using the "hisilicon,sysctrl" device node. But as long as nothing
does, this seems fine.

	Arnd
