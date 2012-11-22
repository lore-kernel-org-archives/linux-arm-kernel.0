From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 22 Nov 2012 08:56:04 +0530
Subject: [PATCH 1/3] CLK: uninline clk_prepare() and clk_unprepare()
In-Reply-To: <20121122031117.GE25470@core.coreip.homeip.net>
References: <1353403339-11679-1-git-send-email-dmitry.torokhov@gmail.com>
 <1353403339-11679-2-git-send-email-dmitry.torokhov@gmail.com>
 <CAKohpo=B_7rVwePziyNe0rTMokcib_FgEN28cy4nByAzbUyaqg@mail.gmail.com>
 <20121121204324.21126.99677@nucleus>
 <20121121205424.GA25470@core.coreip.homeip.net>
 <20121121223859.GQ3290@n2100.arm.linux.org.uk>
 <20121122021750.GD25470@core.coreip.homeip.net>
 <20121122031117.GE25470@core.coreip.homeip.net>
Message-ID: <CAKohpo=emfJgjm8cg0yS+qoaB-kmxHP1to9B-Krn0+_pyrWf_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 November 2012 08:41, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> CLK: get rid of HAVE_CLK_PREPARE
>
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> HAVE_CLK_PREPARE is automatically selected by COMMON_CLK and the only
> platform that explicitly selects HAVE_CLK_PREPARE is MXS which has been
> switched to common clk framework, so we can delete this option now.
>
> As part of this change we move declarations of clk_prepare() and
> clk_unprepare() under HAVE_CLK and provide stubs if this option is not
> enabled.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/clk/Kconfig |    4 ---
>  include/linux/clk.h |   68 ++++++++++++++++++++++++---------------------------

Fix imx select line as pointed out by Mike and add:

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
