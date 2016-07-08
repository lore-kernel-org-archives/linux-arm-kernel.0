From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 8 Jul 2016 12:20:58 -0500
Subject: [PATCH] pinctrl: qcom: establish proper EBI2 pin groups
In-Reply-To: <1467933329-2854-1-git-send-email-linus.walleij@linaro.org>
References: <1467933329-2854-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160708172058.GA7896@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2016 at 01:15:29AM +0200, Linus Walleij wrote:
> After some digging around I found documentation (!) of the APQ8060
> EBI2 pin groups. It turns out I first need to split the group in
> two: ebi2cs and ebi2 proper. The chip select pins are kind of
> orthogonal to the other EBI2 pins since CS1B and CS2B can be muxed
> over address bits 7 and 6 (don't know why, but they can). This
> is good to fix up before we add users.
> 
> Also found what the "holes" in the assignment all the way up to
> gpio158 was actually for.
> 
> All mux documentation comes from "Snapdragon(TM) S3 APQ8060-based
> DragonBoard(TM) GPIO User Guide Rev. E August 10, 2012", published
> by Bsquare Corporation.
> 
> As the documentation seems a bit hard to come by I put some comments
> in the group definitions so that it is clear to all readers what
> is going on here and what the lines are used for.
> 
> Cc: Bj?rn Andersson <bjorn.andersson@linaro.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Seems reasonable.  I'd presume the Documentation needs updating too for the new
groups.

Reviewed-by: Andy Gross <andy.gross@linaro.org>
