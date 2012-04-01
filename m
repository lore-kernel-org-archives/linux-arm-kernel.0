From: sboyd@codeaurora.org (Stephen Boyd)
Date: Sun, 01 Apr 2012 08:26:10 -0700
Subject: [PATCH 2/2] clkdev: Implement managed clk_get()
In-Reply-To: <1333279960-8497-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1333279960-8497-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1333279960-8497-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <4F787392.5040308@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/1/2012 4:32 AM, Mark Brown wrote:
> Allow clk API users to simplify their cleanup paths by providing a
> managed version of clk_get().

I was thinking the same thing last week.

>
> Due to the lack of a standard struct clk to look up the device from a
> managed clk_put() is not provided, it would be very unusual to use this
> function so it's not a big loss.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  Documentation/driver-model/devres.txt |    3 +++
>  drivers/clk/clkdev.c                  |   25 +++++++++++++++++++++++++
>  include/linux/clk.h                   |   20 ++++++++++++++++++++
>  3 files changed, 48 insertions(+), 0 deletions(-)
>

But why is this part of clkdev.c? devm_clk_get() should work regardless
of the implementation of clk_get() so can we put it into some other file
that is compiled if HAVE_CLK=y so everyone benefits from this and not
just users who select CLKDEV_LOOKUP?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
