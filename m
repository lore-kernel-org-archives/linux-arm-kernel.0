From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 24 Jun 2013 12:02:27 -0700
Subject: [PATCH v7 00/11] Add generic set_rate clk_ops for PLL35xx and
 PLL36xx for samsung SoCs
In-Reply-To: <51C85F8F.9050501@samsung.com>
References: <1370943076-13461-1-git-send-email-yadi.brar@samsung.com>
 <CAKew6eUOy4=D08v_iq7CTRY5gvt37VAN7Z7WOr2Yt25znDJb2g@mail.gmail.com>
 <CAGm_ybiVZOPBJJ0bYX33wafn1So6aqSAnk7myXZ+Z+RfLBeBQw@mail.gmail.com>
 <1524664.UCV47tfIRU@flatron> <20130621163143.9136.28807@quantum>
 <51C85F8F.9050501@samsung.com>
Message-ID: <20130624190227.20448.68120@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Kukjin Kim (2013-06-24 08:02:39)
> On 06/22/13 01:31, Mike Turquette wrote:
> >
> > Acked-by: Mike Turquette<mturquette@linaro.org>
> >
> > Or I can take this through the clk tree. Either way is fine.
> >
> Mike, please go ahead taking this series into the clk tree for 3.11.

Actually it might be better for you to take it. Patch #5 relies on
drivers/clk/samsung/clk-exynos5420.c which only exists in the samsung
tree.  It was introduced by commit 1609027f, "clk: exynos5420: register
clocks using common clock framework".

And these patches need to be applied with some fuzz to the clk tree due
to other changes which are not in my tree and only present in yours.

The best two options are either for you to take this series or it can be
rebased on top of clk-next, after which I'll apply it.

Regards,
Mike

> 
> Thanks,
> - Kukjin
