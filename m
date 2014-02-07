From: joe@perches.com (Joe Perches)
Date: Fri, 07 Feb 2014 12:51:58 -0800
Subject: [PATCH v5 00/14] Add support for MSM's mmio clock/reset controller
In-Reply-To: <52F53642.3030606@gmail.com>
References: <1389811654-21397-1-git-send-email-sboyd@codeaurora.org>
 <52F45DEE.8020400@gmail.com> <1391749891.15777.31.camel@joe-AO722>
 <52F53642.3030606@gmail.com>
Message-ID: <1391806318.28199.6.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-02-07 at 11:38 -0800, Frank Rowand wrote:
> On 2/6/2014 9:11 PM, Joe Perches wrote:
> > For patch 1, what checkpatch bug might that be?
[]
> Sorry, it is patch 2, not patch 1 ("[PATCH v5 02/14] clk: Add set_rate_and_parent() op"):
> 
>    WARNING: Multiple spaces after return type
>    #188: FILE: include/linux/clk-provider.h:154:
>    +       int             (*set_rate_and_parent)(struct clk_hw *hw,
> 
>    total: 0 errors, 1 warnings, 152 lines checked

Yup, that one might be a bit aggressive.

It's a complaint about function pointer declaration style.

from checkpatch:
------------------------------------------------------
# unnecessary space "type  (*funcptr)(args...)"
			elsif ($declare =~ /\s{2,}$/) {
				WARN("SPACING",
				     "Multiple spaces after return type\n" . $herecurr);
			}
------------------------------------------------------

This is warning about style equivalent to declarations like:

int		foo(int bar);

checkpatch doesn't warn about declarations of that style,
so likely checkpatch shouldn't warn about multiple spaces
after a function pointer return type either.

I don't have a strong opinion one way or another about it.

If you think it should be silenced, it could be either
downgraded to a CHK or removed altogether.
