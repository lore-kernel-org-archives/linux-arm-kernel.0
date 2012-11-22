From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 22 Nov 2012 09:04:18 +0530
Subject: [PATCH 1/3] CLK: uninline clk_prepare() and clk_unprepare()
In-Reply-To: <20121121204324.21126.99677@nucleus>
References: <1353403339-11679-1-git-send-email-dmitry.torokhov@gmail.com>
 <1353403339-11679-2-git-send-email-dmitry.torokhov@gmail.com>
 <CAKohpo=B_7rVwePziyNe0rTMokcib_FgEN28cy4nByAzbUyaqg@mail.gmail.com>
 <20121121204324.21126.99677@nucleus>
Message-ID: <CAKohpo=fNxADu4z9y6R7XBJEvr7ksOOY0LqZ9MfHnBgmDFgBvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 November 2012 02:13, Mike Turquette <mturquette@ti.com> wrote:
> HAVE_CLK logically wraps HAVE_CLK_PREPARE.  There is no point in
> selecting HAVE_CLK_PREPARE without HAVE_CLK.
>
> Looking through the code I see that this used to be the case.  Commit
> 93abe8e "clk: add non CONFIG_HAVE_CLK routines" moved the
> clk_(un)prepare declarations outside of #ifdef CONFIG_HAVE_CLK.  That
> commit was authored by you.  Can you elaborate on why that aspect of the
> patch was needed?

Haha... Caught red handed :(

Before this commit, nothing was enclosed within CONFIG_HAVE_CLK and
this patch only introduced it. I am not really sure, why i kept
prepare/unprepare
out of it though :(

Maybe because some platform at that time is using it directly, without
CONFIG_HAVE_CLK. Not sure.

--
viresh
