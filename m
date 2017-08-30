From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 30 Aug 2017 13:37:04 +0200
Subject: [PATCH 0/3] constify ux500 clk_ops.
In-Reply-To: <1503903761-21730-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503903761-21730-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <CAPDyKFpHH_jU-iYZtgjAPLc9jDvERcPEHcJu-f=7b1P8LvYSqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 August 2017 at 09:02, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
> clk_ops are not supposed to change at runtime. All functions
> working with clk_ops provided by <linux/clk-provider.h> work
> with const clk_ops. So mark the non-const clk_ops as const.
>
> Here, Function "clk_reg_prcc" is used to initialized clk_init_data.
> clk_init_data is working with const clk_ops. So make clk_reg_prcc
> non-const clk_ops argument as const.
>
> Arvind Yadav (3):
>   [PATCH 1/3] clk: ux500: prcmu: constify clk_ops.
>   [PATCH 2/3] clk: ux500: sysctrl: constify clk_ops.
>   [PATCH 3/3] clk: ux500: prcc: constify clk_ops.
>
>  drivers/clk/ux500/clk-prcc.c    |  6 +++---
>  drivers/clk/ux500/clk-prcmu.c   | 14 +++++++-------
>  drivers/clk/ux500/clk-sysctrl.c |  8 ++++----
>  3 files changed, 14 insertions(+), 14 deletions(-)
>
> --
> 1.9.1
>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Mike, Stephen, can you pick this up?

Kind regards
Uffe
