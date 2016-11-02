From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 1 Nov 2016 17:07:41 -0700
Subject: [PATCH v3 1/2] clk: imx: fix integer overflow in AV PLL round rate
In-Reply-To: <CAOMZO5CLMtyZStgDzdiSHo9s8BhXyiapWqDx1L_TmMpH13043g@mail.gmail.com>
References: <cover.1476267249.git.emil@limesaudio.com>
 <4d2e3a91dfb74209735c940b51d7efc9ba2ed69b.1476267249.git.emil@limesaudio.com>
 <20161028014127.GD16026@codeaurora.org>
 <CAOMZO5Co32XUpNFz4Hd2DEmNnMBvD5fKmsyjcmsgawea4dJR9g@mail.gmail.com>
 <20161028181316.GI16026@codeaurora.org>
 <CAOMZO5CLMtyZStgDzdiSHo9s8BhXyiapWqDx1L_TmMpH13043g@mail.gmail.com>
Message-ID: <20161102000741.GY16026@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28, Fabio Estevam wrote:
> On Fri, Oct 28, 2016 at 4:13 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> 
> > The clk-fixes branch is for patches that fix problems in code
> > merged during the merge window as well as small one-liners and
> > things that are causing great pain for people on the latest
> > release. Given that this fixes a regression in v4.8 and we're
> > trying to stabilize v4.9 it looked like it could wait until
> > v4.10.
> 
> The regression affects 4.8 and 4.9.
> 
> > So is there something going on here where the pain is too much to
> > wait for the next merge window? If so the commit text should
> 
> Yes, people reported HDMI issues because of this bug:
> https://www.spinics.net/lists/arm-kernel/msg535304.html
> 
> > mention something about what's causing that pain. Perhaps by
> > referencing the commit that merged outside of clk tree that
> > caused problems.
> 
> This patch clearly states that the problem is caused by ba7f4f557eb6
> ("clk: imx: correct AV PLL rate formula").

That commit isn't outside of clk tree :(

> 
> Since this is a regression, I don't understand why we need to wait
> until 4.10 to get it applied.

Because we're stabilizing the 4.9-rc series and not the 4.8-rc
series and the assumption is people tested code no 4.8 before it
was released. But in cases where that doesn't happen and the bugs
cause problems with testing the latest rc series we just apply
the patch. It sounds like in this case that happened, so I'll
move this patch over to fixes.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
