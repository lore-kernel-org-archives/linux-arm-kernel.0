From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 19 Nov 2014 15:26:23 +0100
Subject: [PATCH v5 2/2] ARM: EXYNOS: PMU: move restart code into pmu driver
In-Reply-To: <000801d003a7$404882a0$c0d987e0$@samsung.com>
References: <1416307650-15162-1-git-send-email-pankaj.dubey@samsung.com>
 <1416307650-15162-3-git-send-email-pankaj.dubey@samsung.com>
 <546B6395.8020403@samsung.com> <000801d003a7$404882a0$c0d987e0$@samsung.com>
Message-ID: <546CA88F.5010406@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/11/14 04:16, Pankaj Dubey wrote:
>>> > > +static int pmu_restart_notify(struct notifier_block *this,
>>> > > +		unsigned long code, void *unused)
>>> > > +{
>>> > > +	pmu_raw_writel(0x1, EXYNOS_SWRESET);
>> > 
>> > Is it also valid on exynos5440 ? Doesn't it cause any harm there ?
>> > Perhaps we could add a comment saying it has not effect on that SoC ?
>> > 
> Seeing original code from exynos.c (restart hook) I can say it's not valid
> for exynos5440.
> But it should not cause any harm as of now, because for exynos54440 PMU will
> not be probed.
> If in future support for exynos5440 PMU gets added, that time one may need
> to consider this
> point. This will be applicable for any SoC which does not have same register
> for restart.

OK, I wasn't aware PMU driver won't be probed for exynos5440 at all.
Anyway, I hope we can get someone testing the patch set on exynos5440.

--
Regards,
Sylwester
