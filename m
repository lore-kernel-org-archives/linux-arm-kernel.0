From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 15 Apr 2016 17:04:43 -0700
Subject: [PATCH v2] clk: let clk_disable() return immediately if clk is
 NULL or error
In-Reply-To: <CAK7LNARbzRLq_NGWJ8CFBBf6w4cVGCNh45fo6JO=+F7FACBSxA@mail.gmail.com>
References: <1459821083-28116-1-git-send-email-yamada.masahiro@socionext.com>
 <20160408003328.GA14441@codeaurora.org>
 <CAK7LNASW+D0B_k97r__AZeYDR5UqNPqn_j1aoQepHz-bGgV2ng@mail.gmail.com>
 <20160414003341.GH14441@codeaurora.org>
 <CAK7LNARbzRLq_NGWJ8CFBBf6w4cVGCNh45fo6JO=+F7FACBSxA@mail.gmail.com>
Message-ID: <20160416000443.GA26353@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/14, Masahiro Yamada wrote:
> 
> OK, now I notice another problem in my code;
> if foo_clk_init() fails for reason [2],
> clk_disable() WARN's due to zero enable_count.
> 
> if (WARN_ON(core->enable_count == 0))
>          return;
> 
> 
> 
> Perhaps, I got screwed up by splitting clock init stuff
> into a helper function.

Yep! Can't we just split the enable/disable out into another
function separate from the clk_get/put part? That would make
things more symmetric and avoid this problem.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
