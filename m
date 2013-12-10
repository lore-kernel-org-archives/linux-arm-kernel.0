From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 10 Dec 2013 03:53:24 +0100
Subject: [GIT PULL FOR v3.14] Renesas R-Car Gen 2 Common Clock Framework
In-Reply-To: <3302362.MUz5Y8N3ER@avalon>
References: <3302362.MUz5Y8N3ER@avalon>
Message-ID: <4153474.4BkU3nU19I@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Wednesday 04 December 2013 22:29:07 Laurent Pinchart wrote:
> Hi Mike,
> 
> As nobody replied to the last version of the patches I will assume that
> either they're perfect, or I've managed to make all reviewers hibernate
> from boredom. Both cases call for a pull request.
> 
> Could you please pull the following three patches for v3.14 ? They have no
> extra compile-time or runtime dependency, but subsequent platform patches
> will depend on them. Could you thus please provide a stable branch that
> Simon can merge in his tree ?

Ping ? I'd like to get this and the patches that depend on it mainlined in 
v3.14.

> Changes compared to v4:
> 
> - Rebased on top of the latest clk-next branch
> - Revert to ARCH_SHMOBILE_MULTI (as in v3) for drivers/clk/Makefile
> 
> The following changes since commit cdf64eeeb0d762585e2126f3024458d199c2635d:
> 
>   clk: exynos5420: fix cpll clock register offsets (2013-12-04 10:46:45
> -0800)
> 
> are available in the git repository at:
> 
>   git://linuxtv.org/pinchartl/fbdev.git clocks/ccf/rcar-gen2-mainline
> 
> for you to fetch changes up to 7135ea019305179dd6f6a99ea7c1e78773eca166:
> 
>   clk: shmobile: Add MSTP clock support (2013-12-04 22:18:36 +0100)
> 
> ----------------------------------------------------------------
> Laurent Pinchart (3):
>       clk: shmobile: Add R-Car Gen2 clocks support
>       clk: shmobile: Add DIV6 clock support
>       clk: shmobile: Add MSTP clock support
> 
>  .../bindings/clock/renesas,cpg-div6-clocks.txt          |  28 +++
>  .../bindings/clock/renesas,cpg-mstp-clocks.txt          |  51 ++++
>  .../bindings/clock/renesas,rcar-gen2-cpg-clocks.txt     |  32 +++
>  drivers/clk/Makefile                                    |   1 +
>  drivers/clk/shmobile/Makefile                           |   7 +
>  drivers/clk/shmobile/clk-div6.c                         | 185 +++++++++++++
>  drivers/clk/shmobile/clk-mstp.c                         | 229 +++++++++++++
>  drivers/clk/shmobile/clk-rcar-gen2.c                    | 298 +++++++++++++
>  include/linux/clk/shmobile.h                            |  19 ++
>  9 files changed, 850 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/clock/renesas,cpg-div6- clocks.txt
>  create mode 100644
> Documentation/devicetree/bindings/clock/renesas,cpg-mstp- clocks.txt
>  create mode 100644
> Documentation/devicetree/bindings/clock/renesas,rcar-gen2- cpg-clocks.txt
>  create mode 100644 drivers/clk/shmobile/Makefile
>  create mode 100644 drivers/clk/shmobile/clk-div6.c
>  create mode 100644 drivers/clk/shmobile/clk-mstp.c
>  create mode 100644 drivers/clk/shmobile/clk-rcar-gen2.c
>  create mode 100644 include/linux/clk/shmobile.h
-- 
Regards,

Laurent Pinchart
