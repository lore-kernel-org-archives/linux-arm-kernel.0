From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 20 Oct 2010 15:48:27 +0900
Subject: [PATCH 0/4] ARM: S5PV310: Add support S5PV310/S5PC210 CPUFREQ
In-Reply-To: <1284777916-23257-1-git-send-email-kgene.kim@samsung.com>
References: <1284777916-23257-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <05b301cb7022$ce47ebd0$6ad7c370$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> This patch adds support CPUFREQ driver for S5PV310 and S5PC210.
> 
> NOTE: This patch dependes on following.
> - ARM: S5PV310: Fix clkset_moutcore_list
> - ARM: S5PV210: Add DMC map_desc table for supporting DMC access
> 
> [PATCH 1/4] ARM: S5PV310: Update CMU registers for CPUFREQ
> [PATCH 2/4] ARM: S5PV310: Add DMC registers and map_desc
> [PATCH 3/4] ARM: S5PV310: Add support CPUFREQ
> [PATCH 4/4] ARM: S5PV310: Update Kconfig and Makefile for supporting
CPUFREQ
> --
> To unsubscribe from this list: send the line "unsubscribe
linux-samsung-soc"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hi,

Basically, this CPUFREQ functionality has no problem, however, now
ARCH_S5PV310 uses ARM private timer(localtimer) as event tick on each CPU
core.
It means that we need some handling on localtimer or anywhere about ARM
clock changing by CPUFREQ driver...now it is not implemented..so I will drop
this patches for -next...I think we can do it at 37-rc.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
