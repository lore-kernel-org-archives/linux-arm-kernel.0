From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sat, 30 Jul 2016 23:23:06 +0800
Subject: [PATCH 2/2] ASoC: sunxi: compatibility for sun6i to SPDIF
In-Reply-To: <20160730152049.GU6215@lukather>
References: <20160730142716.29377-1-codekipper@gmail.com>
 <20160730142716.29377-3-codekipper@gmail.com>
 <170941469890365@web9j.yandex.ru> <20160730152049.GU6215@lukather>
Message-ID: <24431469892186@web18m.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



30.07.2016, 23:20, "maxime.ripard at free-electrons.com" <maxime.ripard@free-electrons.com>:
> On Sat, Jul 30, 2016 at 10:52:45PM +0800, Icenowy Zheng wrote:
>> ?> + if (of_device_is_compatible(pdev->dev.of_node,
>> ?> + "allwinner,sun6i-a31-spdif")) {
>> ?> + host->rst = devm_reset_control_get_optional(&pdev->dev, NULL);
>> ?> + if (IS_ERR(host->rst) && PTR_ERR(host->rst) == -EPROBE_DEFER) {
>> ?> + ret = -EPROBE_DEFER;
>> ?> + dev_err(&pdev->dev, "Failed to get reset: %d\n", ret);
>> ?> + goto err_disable_apb_clk;
>> ?> + }
>> ?> + if (!IS_ERR(host->rst))
>> ?> + reset_control_deassert(host->rst);
>> ?> + }
>> ?> +
>> ?I think you do not need the compatible.
>> ?You can just detect whether the reset is present.
>
> That would weaken the error check. If we're running on the A31 and are
> missing our reset property, it would go unnoticed.
The reset property is in the SoC's dtsi file, so it won't be easily missing...

>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
