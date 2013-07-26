From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 26 Jul 2013 10:42:45 +0800
Subject: [PATCH RESEND 1/2] clk: mmp: use global clock lock
In-Reply-To: <20130716181029.C08D8FAAF3@dev.laptop.org>
References: <20130716181029.C08D8FAAF3@dev.laptop.org>
Message-ID: <CAN1soZw7_3X5pdvp2M-Wp69=7Cr9bp4DDD0qMps4XT6u1s_9mQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 17, 2013 at 2:10 AM, Daniel Drake <dsd@laptop.org> wrote:
> The mmp platform shares a lock between different clock types, and all
> clocks are currently initialized by static bindings.
>
> Move this static/private lock into global context so that it can
> easily be shared by clocks that will be defined by the device tree in
> followup patches.
>
> Signed-off-by: Daniel Drake <dsd@laptop.org>
> ---
>  drivers/clk/mmp/Makefile   |   2 +-
>  drivers/clk/mmp/clk-apbc.c |  38 +++++----------
>  drivers/clk/mmp/clk-apmu.c |  20 ++------
>  drivers/clk/mmp/clk-mmp2.c | 116 ++++++++++++++++++++++-----------------------
>  drivers/clk/mmp/clk.h      |   8 ++--
>  drivers/clk/mmp/common.c   |  13 +++++
>  6 files changed, 92 insertions(+), 105 deletions(-)
>  create mode 100644 drivers/clk/mmp/common.c
>
> Resending after a month without review.
>

Currently lock is defined in pxa910, pxa168 & mmp2 clock driver. Only
one of these driver
could be active in real system. So I can't see any benefit to use the
shared clock lock among
these three drivers.

Regards
Haojian
