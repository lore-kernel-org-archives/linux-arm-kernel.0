From: dianders@chromium.org (Doug Anderson)
Date: Fri, 31 May 2013 10:20:12 -0700
Subject: [PATCH v3 5/6] clk: samsung: Add alias for mout_vpllsrc and
 reorder MUX registration for it
In-Reply-To: <1370003496-19288-6-git-send-email-vikas.sajjan@linaro.org>
References: <1370003496-19288-1-git-send-email-vikas.sajjan@linaro.org>
 <1370003496-19288-6-git-send-email-vikas.sajjan@linaro.org>
Message-ID: <CAD=FV=Wcw7OArXr6mEoSWzvbhqQWGGTP88fc=kTq6iUzqj0YTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vikas and Yadwinder,

On Fri, May 31, 2013 at 5:31 AM, Vikas Sajjan <vikas.sajjan@linaro.org> wrote:
> While trying to get rate of "mout_vpllsrc" MUX (parent) for registering the
> "fout_vpll" (child), we found get rate was failing.
>
> So this patch moves the mout_vpllsrc MUX out of the existing common list
> and registers the mout_vpllsrc MUX before the PLL registrations.
> Its also adds the alias for the mout_vpllsrc MUX.

I think the moving makes sense, but not the alias.  IMHO global
aliases should be avoided unless they can be strongly justified.

In part 6 of this series I see where you're using the alias but I
don't think you need it.  In your case you are a clock provider, so I
think you can use __clk_lookup("mout_vpllsrc") to find your clock.

I will post an update on our gerrit and you can see what you think.
If someone on the list thinks that using __clk_lookup() is a bad idea
and they'd rather see the global alias, please shout.


-Doug
