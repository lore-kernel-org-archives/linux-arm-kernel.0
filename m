From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Apr 2015 15:30:23 +0200
Subject: [PATCH v2 4/6] clk: hi6220: Clock driver support for Hisilicon
 hi6220 SoC
In-Reply-To: <1428916660-25910-5-git-send-email-bintian.wang@huawei.com>
References: <1428916660-25910-1-git-send-email-bintian.wang@huawei.com>
 <1428916660-25910-5-git-send-email-bintian.wang@huawei.com>
Message-ID: <2254597.TWaxeZsKvK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 April 2015 17:17:38 Bintian Wang wrote:
> +#define HI6220_CFG_CSI2PHY     8
> +#define HI6220_ISP_SCLK_GATE   9
> +#define HI6220_ISP_SCLK_GATE1  10
> +#define HI6220_ADE_CORE_GATE   11
> +#define HI6220_CODEC_VPU_GATE  12
> +#define HI6220_MED_SYSPLL      13
> +
> +/* mux clocks */
> +#define HI6220_1440_1200       20
> +#define HI6220_1000_1200       21
> +#define HI6220_1000_1440       22
> +
> +/* divider clocks */
> +#define HI6220_CODEC_JPEG      30
> +#define HI6220_ISP_SCLK_SRC    31
> +#define HI6220_ISP_SCLK1       32
> 

The numbers seem rather arbitrary, and you have both holes as well as duplicate
numbers here. I would suggest you do one of two things instead:

a) have a separate header file per clock driver and make all the
   numbers unique and consecutive within that header

b) use the same numbers as the hardware registers so you can put the
   numbers directly into the dts and don't need a header to create
   an artificial ABI between the clock driver and the boot loader.

	Arnd
