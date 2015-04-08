From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 7 Apr 2015 22:28:25 -0700
Subject: [PATCH v6 0/4] clk: Provide support for always-on clocks
In-Reply-To: <1428432239-4114-1-git-send-email-lee.jones@linaro.org>
References: <1428432239-4114-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20150408052825.GC31970@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07, Lee Jones wrote:
> Lots of platforms contain clocks which if turned off would prove fatal.
> The only way to recover from these catastrophic failures is to restart
> the board(s).  Now, when a clock provider is registered with the
> framework it is possible for a list of always-on clocks to be supplied
> which must be kept ungated.  Each clock mentioned in the newly
> introduced 'clock-always-on' will be clk_prepare_enable()d where the
> normal references will be taken.  This will prevent the common clk
> framework from attempting to gate them during the clk_disable_unused()
> and disable_clock() procedures.

Ah I see now. The disable_clock() part is from the PM core not
the common clock framework. This paragraph could be the commit
text for the binding patch.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
