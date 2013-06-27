From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 26 Jun 2013 22:29:20 -0700 (PDT)
Subject: [PATCH 0/4] Add DVFS support on APE6EVM
In-Reply-To: <1371798638-10530-1-git-send-email-g.liakhovetski@gmx.de>
References: <1371798638-10530-1-git-send-email-g.liakhovetski@gmx.de>
Message-ID: <874nck2kb7.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi

I have no objection.
For all patches

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Guennadi wrote:
> 
> Having added CPUFreq support to the Cortex A15 cores on APE6 (r8a73a4) and 
> DT support to the max8973 regulator driver it is now possible to implement 
> CA15 CPUFreq support on APE6EVM, using a max8972 PMU to adjust SoC's DVFS
> voltage. This series depends on earlier
> 
> "ARM: shmobile: r8a73a4: wait for completion when kicking the clock"
> https://patchwork.kernel.org/patch/2601071/
> "ARM: shmobile: r8a73a4: implement CPU clock scaling for CPUFreq"
> https://patchwork.kernel.org/patch/2601111/
> 
> and requires the following max8973 patches:
> 
> "regulators: max8973: fix multiple instance support"
> http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg456101.html
> "regulators: max8973: initial DT support"
> http://www.mail-archive.com/linux-kernel at vger.kernel.org/msg456102.html
> 
> Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> 
> Guennadi Liakhovetski (4):
>   ARM: shmobile: r8a73a4: safeguard against wrong clk_set_rate() uses
>   ARM: shmobile: r8a73a4: add I2C DT nodes and required clocks
>   ARM: shmobile: ape6evm: add CPUFreq support
>   ARM: shmobile: r8a73a4: add Z2 clock support
> 
>  arch/arm/boot/dts/r8a73a4-ape6evm.dts  |   26 ++++++++++
>  arch/arm/boot/dts/r8a73a4.dtsi         |   81 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-shmobile/clock-r8a73a4.c |   56 +++++++++++++++++++++-
>  3 files changed, 160 insertions(+), 3 deletions(-)
> 
> -- 
> 1.7.2.5
> 
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

---
Kuninori Morimoto

??????????????
??????????????????????
                  ????????????????

Best regards
---
Kuninori Morimoto
