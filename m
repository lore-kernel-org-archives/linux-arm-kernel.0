From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 6 Nov 2013 17:33:39 +0900
Subject: [PATCH 2/3] clk: shmobile: Add MSTP clock support
In-Reply-To: <1383058511-26046-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383058511-26046-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383058511-26046-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <CANqRtoRe2repacDdWhoZxY7sMP=AOhW=Mtwm3P9AgzVvwoBGKA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Tue, Oct 29, 2013 at 11:55 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> MSTP clocks are gate clocks controlled through a register that handles
> up to 32 clocks. The register is often sparsely populated.
>
> Those clocks are found on Renesas ARM SoCs.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  .../bindings/clock/renesas,cpg-mstp-clocks.txt     |  47 +++++
>  drivers/clk/shmobile/Makefile                      |   1 +
>  drivers/clk/shmobile/clk-mstp.c                    | 229 +++++++++++++++++++++
>  include/dt-bindings/clock/r8a7790-clock.h          |  56 +++++
>  4 files changed, 333 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
>  create mode 100644 drivers/clk/shmobile/clk-mstp.c

Thanks for this. The MSTP driver looks fine to me, but..

>  create mode 100644 include/dt-bindings/clock/r8a7790-clock.h

.. why do you bundle r8a7790-specific bits with the generic MSTP
driver in this patch?

It looks to me that you want these r8a7790 bits included with the
r8a7790 support code.

Cheers,

/ magnus
