From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 25 Jun 2014 19:14:53 +0900
Subject: [PATCH v2] arm: exynos: Support cluster power off on
 exynos5420/5800
In-Reply-To: <7hy4wsvdsm.fsf@paris.lan>
References: <1403104722-14848-1-git-send-email-a.kesavan@samsung.com>
 <1403181617-19743-1-git-send-email-a.kesavan@samsung.com>
 <7hy4wsvdsm.fsf@paris.lan>
Message-ID: <01b501cf905e$4e95cf00$ebc16d00$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman wrote:
> 
> Abhilash Kesavan <a.kesavan@samsung.com> writes:
> 
Hi,

> > Turning off a cluster when all 4 cores of the cluster are powered off
> > saves power significantly. Powering off the A15 L2 alone gives around
> > 100mW in savings. Add support for powering off the A15/A7 clusters on
> > exynos5420/5800.
> >
> > The patch enables specific register bits which ensure that:
> >    - cluster L2 will be turned on before the first man is powered up.
> >    - last man will be turned off before the cluster L2 is turned off.
> >    - core is powered down before powering it up.
> >
> > Remove the exynos_cluster_power_control function completely as we can
> > rely on the above mentioned bits rather than polling the cluster power
> > status register.
> >
> > Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> > Acked-by: Nicolas Pitre <nico@linaro.org>
> > ---
> > Change in v2:
> > Added a macro for the COMMON_OPTION register and used it in the MCPM
> > back-end.
> >
> > The patch is based on Linux-next 20140619. It has been tested on an
> > exynos5420-based chromebook using the "/dev/bL_switcher" interface as
> > well as the script provided by Nicolas Pitre and Dave Martin [1].
> >
> > Patch depends on:
> > [v2] ARM: EXYNOS: mcpm: Don't rely on firmware's secondary_cpu_start
> >
> > [1] http://www.spinics.net/lists/linux-samsung-soc/msg31257.html
> 
> Tested on exynos5800/Chromebook2 along with the dependency patch and using
> the script from Dave and Nico.
> 
> Tested-by: Kevin Hilman <khilman@linaro.org>
> 
Kevin, thanks for your test on the board ;-)

Applied into samsung tree.

Thanks,
Kukjin
