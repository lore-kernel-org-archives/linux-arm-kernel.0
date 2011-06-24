From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 24 Jun 2011 16:42:26 +0900
Subject: [PATCH 4/7] ARM: EXYNOS4: Support early wakeup while entering
	sleep mode
In-Reply-To: <20110622145715.GS23234@n2100.arm.linux.org.uk>
References: <1308732405-16664-1-git-send-email-kgene.kim@samsung.com>
	<1308732405-16664-5-git-send-email-kgene.kim@samsung.com>
	<20110622145715.GS23234@n2100.arm.linux.org.uk>
Message-ID: <007401cc3242$48947160$d9bd5420$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:

> Stop bodging stuff (like you have for the SCU stuff.) and start _talking_
> to people if the code doesn't do what you need it to do.

Hi Russell and all,

I'd like to share requirement of EXYNOS4210 PM.

Now if there is wakeup source which is pending before entering suspend mode,
PMU(Power Management Unit) handles WFI instruction as NOP on EXYNOS4210. But
it seems that current cpu_suspend() cannot support this. So how can/should
we handle this case?

And this is another case. For example, assume that ARM is power down mode
and outer cache(L2 cache) data is retention state to use L2 cache data after
wakeup. In this case, according to wakeup sequence, firstly L1 cache is
enabled in cpu_resume() then L2 cache will be enabled which is implemented
in Samsung SoC specific code. So how can be handled the coherency problem
between L1 cache and L2 cache?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
