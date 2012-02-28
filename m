From: B04825@freescale.com (Tabi Timur-B04825)
Date: Tue, 28 Feb 2012 02:15:14 +0000
Subject: [PATCH 4/6] ASoC: fsl: create fsl_utils to accommodate the
 common functions
In-Reply-To: <20120228021520.GC13886@S2101-09.ap.freescale.net>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-5-git-send-email-shawn.guo@linaro.org>
 <4F4BF770.3010205@freescale.com>
 <20120228021520.GC13886@S2101-09.ap.freescale.net>
Message-ID: <4F4C38B1.2020308@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:

> Since fsl_utils.c is created to accommodate the common functions used
> by mpc8610_hpcd.c and p1022_ds.c, I guess you actually meant something
> like the following?
>
> # MPC8610 HPCD Machine Support
> snd-soc-mpc8610-hpcd-objs := mpc8610_hpcd.o fsl_utils.o
> obj-$(CONFIG_SND_SOC_MPC8610_HPCD) += snd-soc-mpc8610-hpcd.o
>
> # P1022 DS Machine Support
> snd-soc-p1022-ds-objs := p1022_ds.o fsl_utils.o
> obj-$(CONFIG_SND_SOC_P1022_DS) += snd-soc-p1022-ds.o

Yes. :-)

>
> I actually started with doing so, but later changed to make fsl_utils
> as a module.  It seems that mpc8610_hpcd and p1022_ds will not be
> built in a single kernel image, but on ARM/IMX, it's very likely that
> multiple machine drivers will be built in a single image, as the ARM
> community is moving to support single image for multiple SoCs.  In
> that case, fsl_utils can not be linked like that but has to be a module.

Ah yes, good point.

-- 
Timur Tabi
Linux kernel developer at Freescale
