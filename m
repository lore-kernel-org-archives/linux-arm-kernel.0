From: drake@endlessm.com (Daniel Drake)
Date: Mon, 14 Jul 2014 16:41:25 +0100
Subject: [PATCH v3 0/4] ARM: EXYNOS: cpuidle: fix AFTR mode on boards with
 secure firmware enabled
In-Reply-To: <1404926274-18411-1-git-send-email-b.zolnierkie@samsung.com>
References: <1404926274-18411-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <CAD8Lp46mp-tHcwGpFd0YHRDE4pKWDoPpUvu-Y0QzxSi-jnYtWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartlomiej,

On Wed, Jul 9, 2014 at 6:17 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> This patch series adds support for AFTR idle mode on boards with
> secure firmware enabled and allows EXYNOS cpuidle driver usage on
> Exynos4x12 SoCs.
>
> It has been tested on Trats2 board (using Exynos4412 SoC with secure
> firmware enabled) on which AFTR mode reduces power consumption by ~12%
> when EXYNOS cpuidle driver is enabled (in both cases the default
> exynos_defconfig config is used and CPU1-3 are offlined).

Thanks for this, I have tested it on ODROID-U2.

I don't have any equipment to measure the power usage, but after
offlining CPUs 1,2,3 via sysfs "online" file, a printk I added
confirms that the system is going to enter aftr mode, and system
stability seems as good as ever.

Is there any automatic way that the cpus should be offlined, or is the
intention that it must be done "by hand" like this?

Thanks,
Daniel
