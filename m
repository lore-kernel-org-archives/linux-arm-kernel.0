From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 9 May 2018 12:02:55 +0800
Subject: [PATCH 5/5] hisi: Consolidate the Kconfigs for the CLOCK_STUB
 and the MAILBOX
In-Reply-To: <CABb+yY2ke__W2ZW4c_Z9CejZzup52ykRDyNecTs0+nkvf5cbNA@mail.gmail.com>
References: <1522811675-12741-1-git-send-email-leo.yan@linaro.org>
 <1522811675-12741-6-git-send-email-leo.yan@linaro.org>
 <CABb+yY2ke__W2ZW4c_Z9CejZzup52ykRDyNecTs0+nkvf5cbNA@mail.gmail.com>
Message-ID: <20180509040255.GF23540@leoy-ThinkPad-X240s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2018 at 09:19:13AM +0530, Jassi Brar wrote:
> On Wed, Apr 4, 2018 at 8:44 AM, Leo Yan <leo.yan@linaro.org> wrote:
> > From: Daniel Lezcano <daniel.lezcano@linaro.org>
> >
> > The current defconfig is inconsistent as it selects the mailbox and
> > the clock for the hi6220 and the hi3660 without having their Kconfigs
> > making sure the dependencies are correct. It ends up when selecting
> > different versions for the kernel (for example when git bisecting)
> > those options disappear and they don't get back, leading to unexpected
> > behaviors. In our case, the cpufreq driver does no longer work because
> > the clock fails to initialize due to the clock stub and the mailbox
> > missing.
> >
> > In order to have the dependencies correctly set when defaulting, let's
> > do the same as commit 3a49afb84ca074e ("clk: enable hi655x common clk
> > automatically") where we select automatically the driver when the
> > parent driver is selected. With sensible defaults in place, we can leave
> > other choices for EXPERT.
> >
> Acked-by: Jassi Brar <jaswinder.singh@linaro.org>

Thanks Jassi & Stephen.

Wei, could you pick this patch?

Thanks,
Leo Yan
