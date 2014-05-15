From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 14 May 2014 23:01:24 -0700
Subject: [GIT PULL] sirf clk update for 3.16
In-Reply-To: <CAGsJ_4z+Y2P1YNTQWC-VsaT3N0Kasd=LvxAbLVLMftnt8gZbkg@mail.gmail.com>
References: <CAGsJ_4z+Y2P1YNTQWC-VsaT3N0Kasd=LvxAbLVLMftnt8gZbkg@mail.gmail.com>
Message-ID: <20140515060124.3084.44286@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Barry Song (2014-05-12 07:45:00)
> Hi Mike,
> 
> can you pull the below update for 3.16? it cleanups the sirf clk codes
> to fix some minor checkpatch issues according to key customer's
> requirement.
> 
> 
> The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:
> 
>   Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/baohua/linux.git
> tags/clk-sirf-for-3.16

Hi Barry,

I get the following warnings when pulling this tag onto the clk-next
branch:

In file included from drivers/clk/sirf/clk-prima2.c:20:0:
drivers/clk/sirf/clk-common.c:199:2: warning: initialization discards ?const? qualifier from pointer target type [enabled by default]
  .parent_names = pll_clk_parents,
  ^
  ... repeats a for every .parent_names instance ...

In file included from drivers/clk/sirf/clk-atlas6.c:20:0:
drivers/clk/sirf/clk-common.c:199:2: warning: initialization discards ?const? qualifier from pointer target type [enabled by default]
  .parent_names = pll_clk_parents,
  ^
  ... repeats a for every .parent_names instance ...

Can you fix up and resubmit?

Regards,
Mike

> 
> for you to fetch changes up to d7ba5ba84c169e369dd3480f3968044f2f8946a8:
> 
>   clk: sirf: fix a bundle of checkpatch issues (2014-05-12 22:32:05 +0800)
> 
> ----------------------------------------------------------------
> clk: sirf: update for 3.16
> 
> fix minor checkpatch issues according to key customers' requirement.
> 
> ----------------------------------------------------------------
> Bin Shi (1):
>       clk: sirf: fix a bundle of checkpatch issues
> 
>  drivers/clk/sirf/clk-atlas6.c |   12 ++++++------
>  drivers/clk/sirf/clk-common.c |   22 ++++++++++++----------
>  drivers/clk/sirf/clk-prima2.c |   10 +++++-----
>  3 files changed, 23 insertions(+), 21 deletions(-)
> 
> -barry
