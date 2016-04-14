From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 13 Apr 2016 17:40:50 -0700
Subject: [PATCH v2] clk: let clk_disable() return immediately if clk is
 NULL or error
In-Reply-To: <20160408100600.GI1668@linux-mips.org>
References: <1459821083-28116-1-git-send-email-yamada.masahiro@socionext.com>
 <20160408003328.GA14441@codeaurora.org>
 <20160408100600.GI1668@linux-mips.org>
Message-ID: <20160414004050.GJ14441@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08, Ralf Baechle wrote:
> 
> While your argument makes perfect sense, Many clk_disable implementations
> are already doing similar checks, for example:
> 
> arch/arm/mach-davinci/clock.c:
> 
[...]
> 
> So should we go and weed out these checks?

Yes, it would be nice to at least make the differing
implementations of the clk API consistent. Of course, we should
really put our efforts towards getting rid of the non-CCF
implementations instead so that there's less confusion overall.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
