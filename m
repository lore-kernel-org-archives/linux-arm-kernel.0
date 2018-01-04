From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 4 Jan 2018 17:07:13 +0100
Subject: [GIT PULL] Allwinner fixes for 4.15
In-Reply-To: <20171228032240.GA2951@wens.csie.org>
References: <20171228032240.GA2951@wens.csie.org>
Message-ID: <CAK8P3a0RvZKbaJaO=QOcp6UWa-Z=awwJRVn_6HKKZVFfT0iXSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 28, 2017 at 4:22 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
>
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-fixes-for-4.15
>
> for you to fetch changes up to eac6a3639decefcc8eb0941dd3cebe79993670ad:
>
>   ARM: dts: sun8i: a711: Reinstate the PMIC compatible (2017-12-19 09:56:57 +0100)
>
> ----------------------------------------------------------------
> Allwinner fixes for 4.15
>
> First, one fix that adds proper regulator references for the EMAC
> external PHYs on A64 boards. The EMAC bindings were developed for 4.13,
> but reverted at the last minute. They were finalized and brought back
> for 4.15. However in the time between, regulator support for the A64
> boards was merged. When EMAC device tree changes were reintroduced,
> this was not taken into account.
>
> Second, a patch that adds OF based modalias uevent for RSB slave devices.
> This has been missing since the introduction of RSB, and recently with
> PMIC regulator support introduced for the A64, has been seen affecting
> distributions, which have the all-important PMIC mfd drivers built as
> modules, which then don't get loaded.
>
> Other minor cleanups include final conversion of raw indices to CCU
> binding macros for sun[4567]i HDMI, cleanup of dummy regulators on the
> A64 SOPINE, a SD card detection polarity fix for the Orange Pi Zero
> Plus2, and adding a missing compatible for the PMIC on the TBS A711
> tablet.

Pulled into fixes, thanks!

       Arnd
