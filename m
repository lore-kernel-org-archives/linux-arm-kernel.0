From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 18 Jul 2018 16:58:32 +0200
Subject: [resend PATCH v4 2/5] clk: mediatek: mt2701-mmsys: switch to
 platform device probing (fwd)
In-Reply-To: <alpine.DEB.2.20.1807181654200.3113@hadrien>
References: <alpine.DEB.2.20.1807181654200.3113@hadrien>
Message-ID: <11ba8df2-21f3-71e5-8467-813eda93f8ec@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/07/18 16:54, Julia Lawall wrote:
> Please check on whether the kfree is still needed.

No it is not needed, thanks for noting.
Matthias

> 
> julia
> 
> ---------- Forwarded message ----------
> Date: Wed, 18 Jul 2018 22:03:48 +0800
> From: kbuild test robot <lkp@intel.com>
> To: kbuild at 01.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Subject: Re: [resend PATCH v4 2/5] clk: mediatek: mt2701-mmsys: switch to
>     platform device probing
> 
> In-Reply-To: <20180717220328.792-3-matthias.bgg@kernel.org>
> References: <20180717220328.792-3-matthias.bgg@kernel.org>
> TO: matthias.bgg at kernel.org
> 
> Hi Matthias,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on sof-driver-fuweitax/master]
> [also build test WARNING on v4.18-rc5 next-20180718]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/matthias-bgg-kernel-org/arm-arm64-mediatek-Fix-mmsys-device-probing/20180718-191916
> base:   https://github.com/fuweitax/linux master
> :::::: branch date: 3 hours ago
> :::::: commit date: 3 hours ago
> 
>>> drivers/clk/mediatek/clk-mt2701-mm.c:128:1-6: WARNING: invalid free of devm_ allocated data
> 
> # https://github.com/0day-ci/linux/commit/555e11caac5f7729e8927939046adbfa2264f9f5
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 555e11caac5f7729e8927939046adbfa2264f9f5
> vim +128 drivers/clk/mediatek/clk-mt2701-mm.c
> 
> e98621182 Shunli Wang      2016-11-04  122
> 555e11caa Matthias Brugger 2018-07-18  123  static int clk_mt2701_mm_remove(struct platform_device *pdev)
> 555e11caa Matthias Brugger 2018-07-18  124  {
> 555e11caa Matthias Brugger 2018-07-18  125  	struct clk_mt2701_mm_priv *private = platform_get_drvdata(pdev);
> 555e11caa Matthias Brugger 2018-07-18  126
> 555e11caa Matthias Brugger 2018-07-18  127  	kfree(private->clk_data);
> 555e11caa Matthias Brugger 2018-07-18 @128  	kfree(private);
> 555e11caa Matthias Brugger 2018-07-18  129
> 555e11caa Matthias Brugger 2018-07-18  130  	return 0;
> 555e11caa Matthias Brugger 2018-07-18  131  }
> 555e11caa Matthias Brugger 2018-07-18  132
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
