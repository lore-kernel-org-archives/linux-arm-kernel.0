From: horms@verge.net.au (Simon Horman)
Date: Sat, 14 Dec 2013 10:26:24 +0900
Subject: [PATCH v4 0/5] Renesas R-Car Gen2 Common Clock Framework arch/
 support
In-Reply-To: <1386770716-21610-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1386770716-21610-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20131214012624.GF12584@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[ CC Magnus ]

On Wed, Dec 11, 2013 at 03:05:11PM +0100, Laurent Pinchart wrote:
> Hello,
> 
> This is a repost of the arch patches from the "[PATCH v3 0/8] Renesas R-Car
> Gen2 Common Clock Framework support" patch series. The first three patches in
> that series have been reposted separately in the "[PATCH v4 0/3] Renesas R-Car
> Gen2 Common Clock Framework drivers" series to get merged through Mike
> Turquette's tree, while this series will go through the ARM SoC tree.
> 
> I've asked Mike to provide a stable branch when merging the CCF driver
> patches.
> 
> Laurent Pinchart (5):
>   ARM: shmobile: r8a7790: Add clock index macros for DT sources
>   ARM: shmobile: r8a7791: Add clock index macros for DT sources
>   ARM: shmobile: r8a7790: Add clocks
>   ARM: shmobile: r8a7790: Reference clocks
>   ARM: shmobile: r8a7791: Add clocks
> 
>  arch/arm/boot/dts/r8a7790.dtsi            | 328 ++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/r8a7791.dtsi            | 313 ++++++++++++++++++++++++++++
>  include/dt-bindings/clock/r8a7790-clock.h | 100 +++++++++
>  include/dt-bindings/clock/r8a7791-clock.h | 105 ++++++++++
>  4 files changed, 846 insertions(+)
>  create mode 100644 include/dt-bindings/clock/r8a7790-clock.h
>  create mode 100644 include/dt-bindings/clock/r8a7791-clock.h

Hi Laurent,

I would like to confirm the dependencies of this series with you.
As I understand things the dependencies that were not present
in renesas-devel-v3.13-rc2-20131211 are as follows.

If any of the patches below can be skipped without breaking this series
or the followup series "[PATCH v4 00/16] Lager and Koelsch multiplatform
support" then I am all for not treating them as dependencies at all.


* [PATCH v4 0/3] Renesas R-Car Gen2 Common Clock Framework drivers
  Status: Waiting for response from Mike Turquette

* mmc: sh_mobile_sdhi: Convert to clk_prepare/unprepare
  Status: Merged by Chris Ball. I believe we need a stable branch from him.

* spi: sh-msiof: Convert to clk_prepare/unprepare
  spi: sh-msiof: Use devm_* managed allocators
  Status: Merged by Mark Brown. I believe we need a stable branch from him.

* usb: gadget: r8a66597-udc: Convert to clk_prepare/unprepare
  Status: In Felipe Balbi's next branch. It is stable, right?

* clocksource: sh_tmu: Add clk_prepare/unprepare support
  clocksource: sh_tmu: Release clock when sh_tmu_register() fails
  clocksource: sh_mtu2: Add clk_prepare/unprepare support
  clocksource: sh_mtu2: Release clock when sh_mtu2_register() fails
  Status: Present in v3.13-rc3. No problem!

* clocksource: sh_cmt: Add clk_prepare/unprepare support
  Status: I think I have dropped the ball here.
          Regardless, I think it it needs to be accepted by Daniel Lezcano

* serial: sh-sci: Convert to clk_prepare/unprepare
  serial: sh-sci: Don't enable/disable port from within break timer
  Status: I have queued these up
