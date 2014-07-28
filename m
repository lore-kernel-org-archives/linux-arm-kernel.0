From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Jul 2014 15:07:05 +0200
Subject: [PATCH v5 7/8] ARM: hisi: set l2 aux for pl310
In-Reply-To: <1406551883-26154-8-git-send-email-haojian.zhuang@linaro.org>
References: <1406551883-26154-1-git-send-email-haojian.zhuang@linaro.org>
 <1406551883-26154-8-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <5452605.1yR4XPQXjB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 July 2014 20:51:22 Haojian Zhuang wrote:
>  DT_MACHINE_START(HIX5HD2_DT, "Hisilicon HIX5HD2 (Flattened Device Tree)")
>         .dt_compat      = hix5hd2_compat,
> +       .l2c_aux_val    = 0x00050000,
> +       .l2c_aux_mask   = 0xfff0ffff,
>         .smp            = smp_ops(hix5hd2_smp_ops),
>  MACHINE_END

What is wrong with the default settings as passed by the boot loader
as you do for Hi3620?

You should be able to just used 0x0 and 0xffffffff here, unless there is
a bug in the hardware and/or the boot loader. You can also override
certain settings by adding the appropriate properties to the l2x0
device node.

Sorry, but this patch is not good as-is.

	Arnd
