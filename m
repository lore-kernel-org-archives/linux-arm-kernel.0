From: dianders@chromium.org (Doug Anderson)
Date: Wed, 12 Jun 2013 13:35:57 -0700
Subject: [PATCH v4 1/6] clk: samsung: Use clk->base instead of directly
 using clk->con0 for PLL3xxx
In-Reply-To: <CAD=FV=VTLkH9oDqr263Kyv=wCEbuQ40VL7mtC73SCMt20NPwgQ@mail.gmail.com>
References: <1370272196-4346-1-git-send-email-yadi.brar@samsung.com>
 <1370272196-4346-2-git-send-email-yadi.brar@samsung.com>
 <CAD=FV=VTLkH9oDqr263Kyv=wCEbuQ40VL7mtC73SCMt20NPwgQ@mail.gmail.com>
Message-ID: <CAD=FV=WmjHgX6oZbid1oovzueJ4Db=DF8pKr1kyNVugWchwk4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yadwinder,

On Wed, Jun 12, 2013 at 1:33 PM, Doug Anderson <dianders@chromium.org> wrote:

> So.  We just found that this type of solution doesn't work on
> exynos5420, since the LOCK and CON registers aren't always 0x100 away
> from each other.  Perhaps you can adjust to use a solution like Andrew
> proposed in <https://gerrit.chromium.org/gerrit/#/c/58411/>?  That way
> we can avoid some churn of changing this code twice.
>
> The number of parameters to the register PLL function is starting to
> get unwieldy.  At some point we'll probably want to pass in a
> structure.  I wonder if now would be the time?  Certainly it would be
> easier to handle changes to the code without touching all of the
> exynos variants...

It's also probably wise to preemptively rebase atop
<https://patchwork.kernel.org/patch/2704761/> since that looks like it
will land in 3.10 and your series is destined for the release after.
