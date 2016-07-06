From: myungjoo.ham@samsung.com (=?UTF-8?B?TXl1bmdKb28gSGFt?=)
Date: Wed, 06 Jul 2016 02:47:45 +0000
Subject: =?UTF-8?B?UkU6IFtQQVRDSCA3LzddIGRldmZyZXE6IGV4eW5vcy1idXM6?=
 =?UTF-8?B?IGFkZCBtaXNzaW5nIG9mX25vZGVfcHV0IGFmdGVyIGNhbGxp?=
 =?UTF-8?B?bmcgb2ZfcGFyc2VfcGhhbmRsZQ==?=
References: <1467366121-14120-1-git-send-email-peter.chen@nxp.com>
 <CGME20160701094927epcas1p43f956ee3465f96e2f9c99b44c0f5b49d@epcas1p4.samsung.com>
Message-ID: <2060150880.435118.1467773265031.JavaMail.weblogic@ep2ml104d>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> --------- Original Message ---------
> Sender : Peter Chen <peter.chen@nxp.com>
> Date   : 2016-07-01 18:49 (GMT+9)
> Title  : [PATCH 7/7] devfreq: exynos-bus: add missing of_node_put after calling of_parse_phandle
>  
> of_node_put needs to be called when the device node which is got
> from of_parse_phandle has finished using.
>  
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Peter Chen <peter.chen@nxp.com>

With the change (build error fix) of the following added, (I'll update)
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>


Cheers,
MyungJoo

> ---
>  drivers/devfreq/exynos-bus.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>  
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 2363d0a..a38b5ec 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -383,7 +383,7 @@ err_clk:
>  static int exynos_bus_probe(struct platform_device *pdev)
>  {
>          struct device *dev = &pdev->dev;
> -        struct device_node *np = dev->of_node;
> +        struct device_node *np = dev->of_node, node;

+	struct device_node *np = dev->of_node, *node;

>          struct devfreq_dev_profile *profile;
>          struct devfreq_simple_ondemand_data *ondemand_data;
>          struct devfreq_passive_data *passive_data;
...
