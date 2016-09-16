From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Sep 2016 10:05:04 +0200
Subject: [RFC PATCH v2 2/5] clk: hi3620: Make 3620 explicit,
 remove wildcard
In-Reply-To: <20160915210505.21878-3-netz.kernel@gmail.com>
References: <20160915210505.21878-1-netz.kernel@gmail.com>
 <20160915210505.21878-3-netz.kernel@gmail.com>
Message-ID: <2638700.UBf5xKAQsK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 15, 2016 4:05:02 PM CEST Marty Plummer wrote:
> diff --git a/drivers/clk/hisilicon/Makefile b/drivers/clk/hisilicon/Makefile
> index e169ec7..2edf3b5 100644
> --- a/drivers/clk/hisilicon/Makefile
> +++ b/drivers/clk/hisilicon/Makefile
> @@ -4,7 +4,7 @@
>  
>  obj-y  += clk.o clkgate-separated.o clkdivider-hi6220.o
>  
> -obj-$(CONFIG_ARCH_HI3xxx)      += clk-hi3620.o
> +obj-$(CONFIG_ARCH_HI3620)      += clk-hi3620.o
>  obj-$(CONFIG_ARCH_HIP04)       += clk-hip04.o
>  obj-$(CONFIG_ARCH_HIX5HD2)     += clk-hix5hd2.o
>  obj-$(CONFIG_COMMON_CLK_HI3519)        += clk-hi3519.o

I'd suggest instead adding a new Kconfig symbol for the clock driver
the same way we handle hi3519.

	Arnd
