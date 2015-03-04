From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Mar 2015 10:53:39 +0100
Subject: [PATCH 1/3] arm64: mediatek: Add config option for mt8173.
In-Reply-To: <1425436267.21342.39.camel@mtksdaap41>
References: <1422342836-27689-1-git-send-email-hongzhou.yang@mediatek.com>
 <20150225111107.GA29206@localhost> <1425436267.21342.39.camel@mtksdaap41>
Message-ID: <2108883.zjHYNOn4mC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 March 2015 10:31:07 Yingjoe Chen wrote:
> Hi,
> 
> Since we support devicetree, we don't need MACH_* to build a working
> kernel. This is true even for our v7 soc. We intend to use it to reduce
> numbers of drivers in product kernel binary.
> Most drivers are shared among the same SoCs family, but some are not.
> Currently for pinctrl driver, we are doing this so user don't need to
> select them one by one:
> 
> config PINCTRL_MT8173
>         def_bool MACH_MT8173
>         select PINCTRL_MTK_COMMON
> 
> Alternatively, we could add these MACH_* to some other places, eg,
> drivers/soc/mediatek. Or we don't add MACH_* at all, and have all
> drivers export their own Kconfig option. User will need to select each
> of them one-by-one.
> 
> What do you think?

I would rather see these as user-selectable options, which has the
other benefit of giving compile-time coverage. For your example,
I'd suggest doing

config PINCTRL_MT8173
        bool "Mediatek MT8173 pin control"
	depends on ARCH_MEDIATEK || COMPILE_TEST
        select PINCTRL_MTK_COMMON
	help
	   ... a useful description ...


	Arnd
