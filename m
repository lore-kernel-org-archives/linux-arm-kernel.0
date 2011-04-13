From: liu.h.jason@gmail.com (Jason Liu)
Date: Wed, 13 Apr 2011 21:39:12 +0800
Subject: [PATCH 4/6] ARM: mxc: don't allow to compile together i.MX51 and
	i.MX53
In-Reply-To: <1302464943-20721-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1302464943-20721-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1302464943-20721-4-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <BANLkTikhScHojqxbK8wW_m9v2sppxkM7-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/11 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> The two SoCs have different PHYS_OFFSETs so it's not (yet) possible to
> compile a single (working) kernel for these.
[...]
> -config ARCH_MX5
> - ? ? ? bool "MX5-based"
> +config ARCH_MX503
> + ? ? ? bool "i.MX50 + i.MX53"
> + ? ? ? select ARCH_MX50_SUPPORTED
> + ? ? ? select ARCH_MX53_SUPPORTED
> + ? ? ? help
> +

I don't think it's a good calling about such ARCH_MX503 here, it will
be confused.
As FSL have mx508 and mx505 something like that SOC naming.

[...]
> --
> 1.7.2.3
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
