From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Wed, 24 Sep 2014 13:06:13 -0400
Subject: [PATCH v2 0/3] ARM: vf610: Fix/add clocksource
In-Reply-To: <1411575610-20895-1-git-send-email-stefan@agner.ch> (Stefan
 Agner's message of "Wed, 24 Sep 2014 18:20:07 +0200")
References: <1411575610-20895-1-git-send-email-stefan@agner.ch>
Message-ID: <87tx3xkkxm.fsf@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 24 Sep 2014, stefan at agner.ch wrote:

> This patchset came out of need for a clocksource which supports
> shutdown.  In the first version I proposed to just replace the current
> clocksource with the ARM Global Timer and even proposed to remove the
> PIT clocksource driver. But Bill Pringlemeir brought up a reasonable
> point why we should keep the PIT clocksource.
>
> Since we need shutdown support for suspend/resume, I added another
> patch which fixes shutdown functionality for the PIT driver. Now it's
> possible to use suspend/resume functionality with each of the two
> clocksources.
>
> Changes in v2:
> - Added shutdown support for PIT clocksource (and hence clocksource
> maintainers as receipient).
> - Create Kconfig entries which allow to choose between the two
> clocksources
> - Clarified commit message
> - Renamed device tree node to "timer"
>
> Stefan Agner (3):
> clocksource: vf_pit_timer: Support shutdown mode
> ARM: dts: vf610: Add ARM Global Timer
> ARM: vf610: Add ARM Global Timer clocksource option
>
> arch/arm/boot/dts/vf610.dtsi       |  8 ++++++++
> arch/arm/mach-imx/Kconfig          | 19 ++++++++++++++++++-
> drivers/clocksource/vf_pit_timer.c |  5 +++++
> 3 files changed, 31 insertions(+), 1 deletion(-)

Acked-by: Bill Pringlemeir <bpringlemeir@nbsps.com>
