From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 14 Nov 2013 19:16:05 +0900
Subject: [PATCH v2 0/7] Renesas R8A7790 Common Clock Framework support
In-Reply-To: <1384052977-30616-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1384052977-30616-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <CANqRtoRfBb_mZ3erk_iSmmjuFJAWetN3THjGQcBhEjVE__2wWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

Thanks for V2, it is looking better and better. Great that r8a7791 and
r8a7790 can share the CPG code. I have now finally got my r8a7791
board replaced so I intend to try your code out on Lager and then see
if I can cook something up on Koelsch.

I have one question related to the CPG. What is your plan regarding
CPU Frequency scaling? I'd like to see "z_clk" and "z2_clk"
implemented together with some way to let CPUFreq scale "z_clk". Can
you please spend some time on that?

Cheers,

/ magnus

On Sun, Nov 10, 2013 at 12:09 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Hello,
>
> This is the second version of the CCF clock drivers for the Renesas R-Car
> R8A7790 (H2) SoC.
>
> The patches are pretty self-explanatory and described in their respective
> commit message. The R8A7790 datasheet is unfortunately not publicly available.
>
> The code is available in my git tree at
>
>         git://linuxtv.org/pinchartl/fbdev.git clocks/ccf/r8a7790
>
> The branch is based on a merge of renesas-devel-v3.12-rc7-20131101, v3.12, and
> clk-prepare patches I've posted earlier on the list (see "[PATCH 00/12] Prepare
> various SH/R Mobile/Car drivers for CCF migration").
>
> Changes compared to v1:
>
> - The core CPG clocks driver now supports the r8a7791 SoC in addition to the
> r8a7790. They are collectively refered to as 'R-Car Gen2'. The driver has thus
> been renamed to clk-rcar-gen2.c. The DT bindings have been updated accordingly.
>
> - Several MSTP clocks have been added to the r8a7790-clock.h header and a new
> header has been added for the r8a7791
>
> - The r8a7790 dtsi patches that add and reference clocks have been added to
> this series.
>
> Cc: devicetree at vger.kernel.org
>
> Laurent Pinchart (7):
>   clk: shmobile: Add R-Car Gen2 clocks support
>   clk: shmobile: Add DIV6 clock support
>   clk: shmobile: Add MSTP clock support
>   ARM: shmobile: r8a7790: Add clock index macros for DT sources
>   ARM: shmobile: r8a7791: Add clock index macros for DT sources
>   ARM: shmobile: r8a7790: Add clocks
>   ARM: shmobile: r8a7790: Reference clocks
>
>  .../bindings/clock/renesas,cpg-div6-clocks.txt     |  27 ++
>  .../bindings/clock/renesas,cpg-mstp-clocks.txt     |  47 ++++
>  .../clock/renesas,rcar-gen2-cpg-clocks.txt         |  32 +++
>  arch/arm/boot/dts/r8a7790-lager-reference.dts      |   2 +-
>  arch/arm/boot/dts/r8a7790-lager.dts                |   2 +-
>  arch/arm/boot/dts/r8a7790.dtsi                     | 310 +++++++++++++++++++++
>  drivers/clk/shmobile/Makefile                      |   7 +-
>  drivers/clk/shmobile/clk-div6.c                    | 185 ++++++++++++
>  drivers/clk/shmobile/clk-mstp.c                    | 229 +++++++++++++++
>  drivers/clk/shmobile/clk-rcar-gen2.c               | 187 +++++++++++++
>  include/dt-bindings/clock/r8a7790-clock.h          |  99 +++++++
>  include/dt-bindings/clock/r8a7791-clock.h          | 104 +++++++
>  include/linux/clk/shmobile.h                       |  19 ++
>  13 files changed, 1247 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
>  create mode 100644 drivers/clk/shmobile/clk-div6.c
>  create mode 100644 drivers/clk/shmobile/clk-mstp.c
>  create mode 100644 drivers/clk/shmobile/clk-rcar-gen2.c
>  create mode 100644 include/dt-bindings/clock/r8a7790-clock.h
>  create mode 100644 include/dt-bindings/clock/r8a7791-clock.h
>  create mode 100644 include/linux/clk/shmobile.h
>
> --
> Regards,
>
> Laurent Pinchart
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
