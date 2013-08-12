From: padma.kvr@gmail.com (Padma Venkat)
Date: Mon, 12 Aug 2013 15:45:15 +0530
Subject: [PATCH 0/4] clk: Samsung: audss: Add support for Exynos5420
In-Reply-To: <1373458313-18970-1-git-send-email-padma.v@samsung.com>
References: <1373458313-18970-1-git-send-email-padma.v@samsung.com>
Message-ID: <CAAgF-Bf_RsayREKxcv5GevPD_seJwiOBrCRnq3eyeZZ7ks_sSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Any comments on this patch set?

Thanks
Padma

On Wed, Jul 10, 2013 at 5:41 PM, Padmavathi Venna <padma.v@samsung.com> wrote:
> This patch set adds support for audio subsystem clks on Exynos5420. Exynos5420
> audio subsystem has a gate bit for ADMA controller and the some of parent clks
> for mout_i2s are also different from Exynos5250. So this patch adds provision
> for supporting both the platforms by passing the parent clk names through
> device tree.
>
> Andrew Bresticker (3):
>   clk: exynos-audss: add support for Exynos 5420
>   clk: exynos-audss: allow input clocks to be specified in device tree
>   ARM: dts: exynos5420: add audio clock controller
>
> Padmavathi Venna (1):
>   ARM: dts: Correct the /include entry on exynos5420 dtsi file
>
>  .../devicetree/bindings/clock/clk-exynos-audss.txt |   38 +++++++++++++++++--
>  arch/arm/boot/dts/exynos5420.dtsi                  |   13 ++++++-
>  drivers/clk/samsung/clk-exynos-audss.c             |   36 ++++++++++++++++--
>  include/dt-bindings/clk/exynos-audss-clk.h         |    3 +-
>  4 files changed, 80 insertions(+), 10 deletions(-)
>
> --
> 1.7.4.4
>
