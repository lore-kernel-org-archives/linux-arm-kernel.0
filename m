From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 6 Dec 2016 15:16:42 -0800
Subject: [PATCH] clk: uniphier: Fix build with gcc-4.4.
In-Reply-To: <CAK7LNATeswNhoFsA90k=qF4Jock0ytNT-pPT6j+0b9MJFJwu9Q@mail.gmail.com>
References: <1480725436-9628-1-git-send-email-vlee@freedesktop.org>
 <CAK7LNATeswNhoFsA90k=qF4Jock0ytNT-pPT6j+0b9MJFJwu9Q@mail.gmail.com>
Message-ID: <20161206231642.GA4388@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03, Masahiro Yamada wrote:
> Hi Vinson,
> 
> 2016-12-03 9:37 GMT+09:00 Vinson Lee <vlee@freedesktop.org>:
> > gcc-4.4 has issues with anonymous unions in initializers.
> >
> >   CC      drivers/clk/uniphier/clk-uniphier-sys.o
> > drivers/clk/uniphier/clk-uniphier-sys.c:45: error: unknown field ?factor? specified in initializer
> >
> > Fixes: 1574d5722636 ("clk: uniphier: remove unneeded member name for union")
> > Signed-off-by: Vinson Lee <vlee@freedesktop.org>
> 
> 
> This driver has COMPILE_TEST option, but kbuild test robot
> did not mention about this.
> 
> 
> 
> This is a bad way of fixing, I think.
> (what if a new member is inserted before the union in the future?)
> 
> Rather, please revert the bad commit.
> 

Reverting on top of clk-next will cause build failures though.
Can you resend the patch series without this first patch please?
I'll apply them then.

I'll go drop all three patches and wreck Andrew's merge of this
patch to -mm.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
