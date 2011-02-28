From: davidb@codeaurora.org (David Brown)
Date: Mon, 28 Feb 2011 10:55:00 -0800
Subject: [PATCH 2/2] msm: clock: Migrate to clkdev
In-Reply-To: <1298482662-27298-3-git-send-email-sboyd@codeaurora.org> (Stephen
	Boyd's message of "Wed, 23 Feb 2011 09:37:42 -0800")
References: <1298482662-27298-1-git-send-email-sboyd@codeaurora.org>
	<1298482662-27298-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <8yay6500z23.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 23 2011, Stephen Boyd wrote:

> Migrating to clkdev has several advantages:
>
>  * Less code in mach-msm/clock.c
>
>  * A more robust clk_get() implementation
>
>  * clk_add_alias() support
>
>  * clk_get_sys() support
>
> In general, this will help board authors setup clock aliases and
> break the dependency on device pointers in the clock tables.
>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm/Kconfig                        |    1 +
>  arch/arm/mach-msm/board-msm7x30.c       |    1 +
>  arch/arm/mach-msm/board-msm8960.c       |    1 +
>  arch/arm/mach-msm/board-qsd8x50.c       |    1 +
>  arch/arm/mach-msm/board-trout.c         |    1 +
>  arch/arm/mach-msm/clock-7x30.h          |   31 +++++++++++++-----------
>  arch/arm/mach-msm/clock-pcom.h          |   16 +++++++-----
>  arch/arm/mach-msm/clock.c               |   39 ++++++++-----------------------
>  arch/arm/mach-msm/clock.h               |    2 -
>  arch/arm/mach-msm/devices-msm7x00.c     |   32 ++++++++++++------------
>  arch/arm/mach-msm/devices-msm7x30.c     |    5 ++-
>  arch/arm/mach-msm/devices-qsd8x50.c     |   23 +++++++++--------
>  arch/arm/mach-msm/devices.h             |    8 ++++--
>  arch/arm/mach-msm/include/mach/board.h  |    4 +-
>  arch/arm/mach-msm/include/mach/clkdev.h |   19 +++++++++++++++
>  15 files changed, 98 insertions(+), 86 deletions(-)
>  create mode 100644 arch/arm/mach-msm/include/mach/clkdev.h

This doesn't seem to apply cleanly.  Do you mind resending this against
the msm for/next branch.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
