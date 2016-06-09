From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 09 Jun 2016 16:54:54 +0200
Subject: [PATCH 09/12] mmc: sdhci-xenon: add initial Xenon eMMC driver
In-Reply-To: <201606092223.3kHMu0m3%fengguang.wu@intel.com> (kbuild test
 robot's message of "Thu, 9 Jun 2016 22:20:45 +0800")
References: <201606092223.3kHMu0m3%fengguang.wu@intel.com>
Message-ID: <87r3c6mmyp.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I added Arnd because he seems to have a good knoweldge of the Kconfig
stuff.

 On jeu., juin 09 2016, kbuild test robot <lkp@intel.com> wrote:

> Hi,
>
> [auto build test ERROR on ulf.hansson-mmc/next]
> [also build test ERROR on v4.7-rc2 next-20160609]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Gregory-CLEMENT/Add-SDHCI-Xenon-driver/20160609-151403
> base:   https://git.linaro.org/people/ulf.hansson/mmc next
> config: x86_64-allmodconfig (attached as .config)
> compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
>
> All errors (new ones prefixed by >>):
>
>    drivers/built-in.o: In function `sdhci_xenon_remove':
>>> sdhci-xenon.c:(.text+0x311234): undefined reference to `sdhci_remove_host'
>>> sdhci-xenon.c:(.text+0x31123c): undefined reference to `sdhci_pltfm_free'
>    drivers/built-in.o: In function `sdhci_xenon_delay_adj_test':
>>> sdhci-xenon.c:(.text+0x31213b): undefined reference to `card_alive'
>    drivers/built-in.o: In function `sdhci_xenon_set_uhs_signaling':
>>> sdhci-xenon.c:(.text+0x312456): undefined reference to `sdhci_set_uhs_signaling'
>    drivers/built-in.o: In function `sdhci_xenon_probe':
>>> sdhci-xenon.c:(.text+0x31258c): undefined reference to `sdhci_pltfm_init'
>>> sdhci-xenon.c:(.text+0x3125d3): undefined reference to `mmc_of_parse'
>>> sdhci-xenon.c:(.text+0x312651): undefined reference to `sdhci_get_of_property'
>>> sdhci-xenon.c:(.text+0x312840): undefined reference to `sdhci_add_host'
>    sdhci-xenon.c:(.text+0x312904): undefined reference to `sdhci_pltfm_free'
>    drivers/built-in.o: In function `sdhci_xenon_reset':
>>> sdhci-xenon.c:(.text+0x313c11): undefined reference to `sdhci_reset'
>>> drivers/built-in.o:(.data+0x1d7df0): undefined reference to `sdhci_pltfm_pmops'
>>> drivers/built-in.o:(.data+0x1d7eb0): undefined reference to `sdhci_set_clock'
>>> drivers/built-in.o:(.data+0x1d7ef0): undefined reference to `sdhci_set_bus_width'

These symbols are part of the drivers/mmc/host/sdhci.c which is build
when CONFIG_MMC_SDHCI is enabled. However CONFIG_MMC_XENON_SDHCI depends
on CONFIG_MMC_SDHCI_PLTFM which depends on CONFIG_MMC_SDHCI.

So I wonder how we can have a sition with sdhci-xenon.c built but not
sdhci.c.

Any idea?

Thanks,

Gregory

>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
