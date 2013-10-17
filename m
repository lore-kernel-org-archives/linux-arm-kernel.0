From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 17 Oct 2013 14:47:01 +0100
Subject: [RESEND PATCH v2 0/6] Update Kona drivers to use clocks
In-Reply-To: <1381960030-1640-1-git-send-email-tim.kryger@linaro.org>
References: <1381960030-1640-1-git-send-email-tim.kryger@linaro.org>
Message-ID: <20131017134701.GC24056@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 10:47:04PM +0100, Tim Kryger wrote:
> This series declares the clocks present on bcm11351 (aka bcm281xx) SoCs
> to be fixed at the rates configured by development bootloaders and then
> updates the Kona drivers to make use of clock calls where appropriate.
> 
> This patch series depends on the following three commits being present:
> 
> https://lkml.org/lkml/2013/9/18/409
> https://lkml.org/lkml/2013/9/20/305
> http://www.spinics.net/lists/arm-kernel/msg274973.html
> 
> Changes in v2:
>   - Renamed bsc4_clk to pmu_bsc_clk
> 
> Tim Kryger (6):
>   ARM: dts: Declare clocks as fixed on bcm11351
>   ARM: dts: Specify clocks for UARTs on bcm11351
>   ARM: dts: Specify clocks for SDHCIs on bcm11351
>   clocksource: kona: Add basic use of external clock
>   ARM: dts: Specify clocks for timer on bcm11351
>   mmc: sdhci-bcm-kona: Add basic use of clocks
> 
>  arch/arm/boot/dts/bcm11351.dtsi      | 111 +++++++++++++++++++++++++++++++++--
>  drivers/clocksource/bcm_kona_timer.c |  14 ++++-
>  drivers/mmc/host/sdhci-bcm-kona.c    |  30 +++++++++-

This requires a description in the binding documents, so we can figure
out which clocks we need to describe, and how to describe them.

Thanks,
Mark.
