From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 30 Aug 2016 14:51:53 -0700
Subject: [PATCH RESEND] clk: core: Force setting the phase delay when no
 change
In-Reply-To: <20160824092212.D088561C49@smtp.codeaurora.org>
References: <20160824092212.D088561C49@smtp.codeaurora.org>
Message-ID: <20160830215153.GE12510@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24, Jean-Francois Moine wrote:
> This patch reverts the commit 023bd7166be0595d18220dfd5c9765b3970f6ef3
> (clk: skip unnecessary set_phase if nothing to do), fixing two
> problems:
> - in some SoCs, the hardware phase delay depends on the rate ratio of
>   the clock and its parent. So, changing this ratio may imply to set
>   new hardware values, even if the logical delay is the same.
> - when the delay was the same as previously, an error was returned.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---

Applied to clk-next. We can revisit optimizing things later like
the original patch attempted, but fixing the second problem is
enough to warrant a revert for now.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
