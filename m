From: mturquette@baylibre.com (Michael Turquette)
Date: Mon, 15 Feb 2016 15:31:02 -0800
Subject: [PATCH 0/3] clk: mvebu: initial support for AP806 clocks
In-Reply-To: <1455521698-7905-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1455521698-7905-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160215233102.2278.88855@quark.deferred.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Quoting Thomas Petazzoni (2016-02-14 23:34:55)
> Hello,
> 
> The following set of patches add initial support for the main clocks
> found in the AP806 hardware block, which is the central block used in
> the newest Marvell 7K and 8K 64-bits processors.
> 
> Two new drivers are added, one for the so-called "core" clocks and one
> for the "ring" clocks. The latter are child clocks from one of the
> core clocks. The "core" clocks are fixed rate clocks, but their rate
> is calculated from values in the Sample At Reset register.
> 
> The support for the Marvell 7K/8K platform (Device Tree, etc.) will be
> submitted as a separate patch series.

Yay, new SoC! Just FYI, we worked out an agreement in December[0] that
the clk git tree can take DT bindings and headers, and we'll always host
them in an immutable branch by default in case arm-soc (or anyone else)
needs them. Stephen and I are doing this now.

It's nice for us to review those bindings at the same time that we
review the driver.

[0] http://lkml.kernel.org/r/<20151231001859.19557.99512@quark.deferred.io>

Best regards,
Mike

> 
> Thanks!
> 
> Thomas
> 
> Thomas Petazzoni (3):
>   clk: unconditionally recurse into clk/mvebu/
>   clk: mvebu: add AP806 core clock driver
>   clk: mvebu: add AP806 ring clock driver
> 
>  .../clock/mvebu-armada-ap806-core-clock.txt        |  33 ++++++
>  .../clock/mvebu-armada-ap806-ring-clock.txt        |  32 ++++++
>  drivers/clk/Makefile                               |   2 +-
>  drivers/clk/mvebu/Kconfig                          |   6 ++
>  drivers/clk/mvebu/Makefile                         |   3 +-
>  drivers/clk/mvebu/ap806-core.c                     | 112 +++++++++++++++++++++
>  drivers/clk/mvebu/ap806-ring.c                     |  65 ++++++++++++
>  7 files changed, 251 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/mvebu-armada-ap806-core-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/mvebu-armada-ap806-ring-clock.txt
>  create mode 100644 drivers/clk/mvebu/ap806-core.c
>  create mode 100644 drivers/clk/mvebu/ap806-ring.c
> 
> -- 
> 2.6.4
> 
