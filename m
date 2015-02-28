From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Sat, 28 Feb 2015 14:51:17 +0530
Subject: [PATCH 3/4] clk: Provide always-on clock support
In-Reply-To: <1425071674-16995-4-git-send-email-lee.jones@linaro.org>
References: <1425071674-16995-1-git-send-email-lee.jones@linaro.org>
 <1425071674-16995-4-git-send-email-lee.jones@linaro.org>
Message-ID: <CAJe_Zhf=GBb8AfnTLaGxGcZkVSm9TtdnTsmpH_MBmbMT8ViMDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 February 2015 at 02:44, Lee Jones <lee.jones@linaro.org> wrote:
> Lots of platforms contain clocks which if turned off would prove fatal.
> The only way to recover from these catastrophic failures is to restart
> the board(s).  Now, when a clock is registered with the framework it is
> compared against a list of provided always-on clock names which must be
> kept ungated.  If it matches, we enable the existing CLK_IGNORE_UNUSED
> flag, which will prevent the common clk framework from attempting to
> gate it during the clk_disable_unused() procedure.
>
If a clock is critical on a certain board, it could be got+enabled
during early boot so there is always a user.
To be able to do that from DT, maybe add a new, say, CLK_ALWAYS_ON
flag could be made to initialize the clock with one phantom user
already. Or just reuse the CLK_IGNORE_UNUSED?

-Jassi
