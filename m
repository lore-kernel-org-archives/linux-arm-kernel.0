From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 22 Nov 2012 15:38:52 +0530
Subject: [PATCH 1/3] CLK: uninline clk_prepare() and clk_unprepare()
In-Reply-To: <20121122093033.GA5764@n2100.arm.linux.org.uk>
References: <1353403339-11679-1-git-send-email-dmitry.torokhov@gmail.com>
 <1353403339-11679-2-git-send-email-dmitry.torokhov@gmail.com>
 <CAKohpo=B_7rVwePziyNe0rTMokcib_FgEN28cy4nByAzbUyaqg@mail.gmail.com>
 <20121121204324.21126.99677@nucleus>
 <20121121205424.GA25470@core.coreip.homeip.net>
 <20121121223859.GQ3290@n2100.arm.linux.org.uk>
 <20121122021750.GD25470@core.coreip.homeip.net>
 <20121122093033.GA5764@n2100.arm.linux.org.uk>
Message-ID: <CAKohpomH7ke+4jJvpDvetFEqmD761BCoryq_=kbygY0bL3j=SQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 22 November 2012 15:00, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Err, no you haven't, not with that grep.  What you've found are the places
> which enable this, and say "yes, I have clk_prepare".
>
> What HAVE_CLK_PREPARE is about though is providing a transition path between
> drivers using clk_prepare() to platforms which _don't_ have a clk_prepare()
> implementation - and when it's unset, it provides a default implementation.

Just to make it more clear:

Categories of platforms:
- COMMON_CLK=y: For them it is mandatory to have clk_[un]prepare
- COMMON_CLK=n:
   - HAVE_CLK=n: dummy implementation suggested in this patch is enough for it.
      Even existing implementation too.
   - HAVE_CLK=y:
       - HAVE_CLK_PREPARE=y: Platforms must have their own implementation of
          this routine and so a prototype is enough in clk.h
       - HAVE_CLK_PREPARE=n: This is the problematic place. Who will provide
         implementation of dummy routine here? With current patch
Neither platform
         nor clk.h is providing that.

Sorry for not reviewing it properly :(

--
viresh
