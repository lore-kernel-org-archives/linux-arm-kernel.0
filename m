From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 2 Mar 2015 08:36:52 +0000
Subject: [PATCH 3/4] clk: Provide always-on clock support
In-Reply-To: <CAJe_Zhf=GBb8AfnTLaGxGcZkVSm9TtdnTsmpH_MBmbMT8ViMDg@mail.gmail.com>
References: <1425071674-16995-1-git-send-email-lee.jones@linaro.org>
 <1425071674-16995-4-git-send-email-lee.jones@linaro.org>
 <CAJe_Zhf=GBb8AfnTLaGxGcZkVSm9TtdnTsmpH_MBmbMT8ViMDg@mail.gmail.com>
Message-ID: <20150302083652.GE31325@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 28 Feb 2015, Jassi Brar wrote:

> On 28 February 2015 at 02:44, Lee Jones <lee.jones@linaro.org> wrote:
> > Lots of platforms contain clocks which if turned off would prove fatal.
> > The only way to recover from these catastrophic failures is to restart
> > the board(s).  Now, when a clock is registered with the framework it is
> > compared against a list of provided always-on clock names which must be
> > kept ungated.  If it matches, we enable the existing CLK_IGNORE_UNUSED
> > flag, which will prevent the common clk framework from attempting to
> > gate it during the clk_disable_unused() procedure.
> >
> If a clock is critical on a certain board, it could be got+enabled
> during early boot so there is always a user.

I tried this.  There was push-back from the DT maintainers.

  http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/324417.html

> To be able to do that from DT, maybe add a new, say, CLK_ALWAYS_ON
> flag could be made to initialize the clock with one phantom user
> already. Or just reuse the CLK_IGNORE_UNUSED?

How is that different to what this set is doing?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
