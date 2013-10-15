From: olof@lixom.net (Olof Johansson)
Date: Tue, 15 Oct 2013 11:14:42 -0700
Subject: [PATCH v2 0/7] Tegra124 clock support
In-Reply-To: <1381850098-12357-1-git-send-email-pdeschrijver@nvidia.com>
References: <1381850098-12357-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <CAOesGMiXDqO9tKaj1s_hN32q_bPdLVojWPe2LweURDq-b2784w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[devicetree to bcc]

Peter,

Please don't post driver/platform patches to the devicetree list. Only
bindings updates should be posted here.

Otherwise the volume of patches make the people who need to see the
and review the bindings run for the hills. :-)


-Olof

On Tue, Oct 15, 2013 at 8:14 AM, Peter De Schrijver
<pdeschrijver@nvidia.com> wrote:
> This series introduces support for the Tegra124 CAR clocks.
> Based on '[PATCH v3 00/12] Introduce common infra for tegra clocks'
>
> changes since v1:
>
> + suspend/resume for LP1 (Joseph Lo)
> + fixed some comments
> + account for changes to the common infra code
>
> Joseph Lo (2):
>   clk: tegra124: add wait_for_reset and disable_clock for
>     tegra_cpu_car_ops
>   clk: tegra124: add suspend/resume function for tegra_cpu_car_ops
>
> Peter De Schrijver (5):
>   clk: tegra: Add support for PLLSS
>   clk: tegra: Add periph regs bank X
>   clk: tegra124: Add common clk IDs to clk-id.h
>   clk: tegra124: Add new peripheral clocks
>   clk: tegra124: Add support for Tegra124 clocks
>
>  drivers/clk/tegra/Makefile               |    1 +
>  drivers/clk/tegra/clk-id.h               |   20 +
>  drivers/clk/tegra/clk-pll.c              |  172 ++++
>  drivers/clk/tegra/clk-tegra-periph.c     |   55 ++
>  drivers/clk/tegra/clk-tegra124.c         | 1430 ++++++++++++++++++++++++++++++
>  drivers/clk/tegra/clk.c                  |   10 +
>  drivers/clk/tegra/clk.h                  |    5 +
>  include/dt-bindings/clock/tegra124-car.h |  341 +++++++
>  8 files changed, 2034 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/clk/tegra/clk-tegra124.c
>  create mode 100644 include/dt-bindings/clock/tegra124-car.h
>
> --
> 1.7.7.rc0.72.g4b5ea.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
